Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FC6760C83
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjGYH7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjGYH66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:58:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06609E5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:58:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F2EB6606F97;
        Tue, 25 Jul 2023 08:58:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690271935;
        bh=EcBa51UDSzC9yoULUX6VrJ7gf1EtZAt7KrCQOJ4AZv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FUxRFjlbD+YFzZ9kzfmNA9K2+szybOMzGFar7er1WYgKYuf0eICkPTwI3dtJQSFF5
         FuqGy+0TAXaV1EXMGVvfRmqfqmMnu0IaRBZc8iJbtwdQ7YAq9N3K8IZrju2igz1YWx
         FQPDQbex+WYbg2Glf/s8K4ET646kxwzLvufhQYReJw0nUy+e11oLQ9b5ZXX0RyJsNb
         BGa9Y9YQbMMyvlqysVjDvaYEfOBbXI+Zf+sL9sC3cUPB0T8UJA/VaORLM6keETnsej
         opg6TRJJAfkym2E84FdocfKyPL92109gaiHoWbxr0gbCGenzPTPb5ziG5qdfV4ho68
         CjuBT5OK18TSQ==
Date:   Tue, 25 Jul 2023 09:58:51 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v14 10/12] drm/shmem-helper: Refactor locked/unlocked
 functions
Message-ID: <20230725095851.5cbd7b6d@collabora.com>
In-Reply-To: <20230725094702.4322fbb5@collabora.com>
References: <20230722234746.205949-1-dmitry.osipenko@collabora.com>
        <20230722234746.205949-11-dmitry.osipenko@collabora.com>
        <20230725094702.4322fbb5@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 09:47:02 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Sun, 23 Jul 2023 02:47:44 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
> > Add locked/unlocked postfixes to drm-shmem function names to make clear
> > where reservation lock is taken and where not.  
> 
> Uh, ignore my comment on patch 1 then...
> 
> > Add more common helpers to drm_gem_shmem_helper.h  
> 
> I'd do the renaming and exporting in separate patches.

Actually, I'd refrain from exporting functions until someone needs
them, as you rightfully pointed out in your previous reply.

> 
> > 
> > Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>  

