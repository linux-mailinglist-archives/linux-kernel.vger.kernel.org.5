Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3FF7AB17E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjIVL65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjIVL6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:58:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C001B2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:58:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:d3ea:1c7:41fd:3038])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6520B6607298;
        Fri, 22 Sep 2023 12:58:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695383924;
        bh=m/nPO3u2dtkBOwJtWh5MiRmfd1HuFw6fSZbWZsf3Wv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JiYUUHY31kwZsSWTaJSvOhWIjm7sm1VXUhtIKi9S5m+lKJPDFPoo4LhF9Lc/4BJqG
         fI8T9NF+owxbdmgbZYsUDGNY5Y5jCJHYc4LkEHok5cLTtvNw1ZGaobR8ttPdneOZcr
         LqFJnTm6DY2q+Jp82tEVIU/Ex7Tzhv3mDDWvA/8GzhtiDskyIOxQ5Z+uqnbJhb1TLe
         kM8tURuEBXloVJis/5hpZTGoF2rpKJdiXMF9LEXhnfIeEbhTFZipFG3brEk52/+01S
         1ukjKdPXTWPAUqamteWN7+ikfwVfdcQqCBWzoA/tOyzsqrUprYATWizD3gwzriQAwU
         xLvVDQEV3uPUg==
Date:   Fri, 22 Sep 2023 13:58:42 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v4 6/8] drm/gpuvm: add drm_gpuvm_flags to
 drm_gpuvm
Message-ID: <20230922135842.242c865d@collabora.com>
In-Reply-To: <20230920144343.64830-7-dakr@redhat.com>
References: <20230920144343.64830-1-dakr@redhat.com>
        <20230920144343.64830-7-dakr@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 16:42:39 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> +/**
> + * enum drm_gpuvm_flags - flags for struct drm_gpuvm
> + */
> +enum drm_gpuvm_flags {
> +	/**
> +	 * @DRM_GPUVM_USERBITS: user defined bits
> +	 */
> +	DRM_GPUVM_USERBITS = (1 << 0),

Nit: I tried declaring driver-specific flags, and I find this
counter-intuitive. You basically end up with something like:

enum my_gpuvm_flags {
	MY_FLAG_X = DRM_GPUVM_USERBITS,
	MY_FLAG_Y = DRM_GPUVM_USERBITS << 1,
};

instead of the usual

enum my_gpuvm_flags {
	MY_FLAG_X = BIT(0),
	MY_FLAG_Y = BIT(1),
};

pattern.

Another issue I see coming is if we end up adding more core flags and
drivers start falling short of bits for their own flags. This makes me
wonder if we shouldn't kill this notion of USER flags and let drivers
store their flags in some dedicated field, given they're likely to
derive drm_gpuvm and drm_gpuva with their own object anyway.

> +};
> +

