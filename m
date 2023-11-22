Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C797F3EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjKVH0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjKVH0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:26:09 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352E5A1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=a/kbKeCEYGAl3Cpnin1U0qriK39m5Dp28jqz4j6h/qM=;
        t=1700637962; x=1701847562; b=gs3d1xjUGFslj1Iub0ExAgpvmls8WVy84RzzN2bwQr8i3eE
        4DxYxeauhK5VWdt/s558W5Ua38mUPppyUEobQz3OVwrkVLXYoRQj3dZwOsgjSdmfiLzbnZjBO/TdY
        ZABsB48SxtJz3MI7n6uC3MHMTa5hAwW8uujpObOvvhUR+7iBP0M2eNA8G9cIUo4DQAN5//Dx+Fzd6
        /J1FiaQbtGfasltfau/dktc0q9mNz4GyWApom7/sl11zMCnxMS8U1k5HFNhOnW9CqFZdduoO9qJil
        JdlUbKW/2oamWClccNQHtaRtqvRyhjLaW4wMtvZLa1pQFbKuavHGoiGxhB4MZIIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r5hcS-0000000HUHW-0f9N;
        Wed, 22 Nov 2023 08:25:56 +0100
Message-ID: <3fa7ec68a0302667f1b73682e4db96f6ba618397.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Use swap() instead of open coding it
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, richard@nod.at
Cc:     anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Date:   Wed, 22 Nov 2023 08:25:54 +0100
In-Reply-To: <20231122032518.53305-1-jiapeng.chong@linux.alibaba.com>
References: <20231122032518.53305-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-22 at 11:25 +0800, Jiapeng Chong wrote:
> Swap is a function interface that provides exchange function. To avoid
> code duplication, we can use swap function.
>=20
> ./arch/um/os-Linux/sigio.c:81:28-29: WARNING opportunity for swap().
>=20

Hm. There's already a use of swap() here in this file, but I actually
think we should revert that? This is basically userspace code, not
kernel code, so I don't think it should include linux headers, even if
those happen to be "standalone enough" right now to work.

johannes
