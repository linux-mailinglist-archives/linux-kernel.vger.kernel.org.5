Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63DF78EB2B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbjHaK5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbjHaK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CDBCF9;
        Thu, 31 Aug 2023 03:57:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B454D60F12;
        Thu, 31 Aug 2023 10:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16A2C433C7;
        Thu, 31 Aug 2023 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693479421;
        bh=caetN6+oskSH08smnopyy2xlFSz88PRY0E9DEwG49oE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tc/hRlgaXXXcp9mVUDRHyxASla0XvJNGsZi67nx1dEMb7s8NS3ITP2KHUaO5odwFb
         uDMnjBd9Dgp97/oBrC7V+gWSc6Bu/XknCsbDOL82sFSp9wPwGjSXEr+NndXEyIllzr
         vKKsVVZARq8N1GKopGBrKsGZ00r3CfdjpCOq8RXM=
Date:   Thu, 31 Aug 2023 12:56:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     Chia-I Wu <olvaffe@gmail.com>, Sasha Levin <sashal@kernel.org>,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        stable@vger.kernel.org, Lang Yu <Lang.Yu@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH AUTOSEL 5.10 13/22] drm/amdgpu: install stub fence into
 potential unused fence pointers
Message-ID: <2023083145-scoured-celery-2511@gregkh>
References: <20230724012419.2317649-1-sashal@kernel.org>
 <20230724012419.2317649-13-sashal@kernel.org>
 <CAPaKu7RTgAMBLHbwtp4zgiBSDrTFtAj07k5qMzkuLQy2Zr+sZA@mail.gmail.com>
 <55fc4a28-1e17-44df-2069-a688828080e6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55fc4a28-1e17-44df-2069-a688828080e6@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 12:27:27PM +0200, Christian König wrote:
> Am 30.08.23 um 20:53 schrieb Chia-I Wu:
> > On Sun, Jul 23, 2023 at 6:24 PM Sasha Levin <sashal@kernel.org> wrote:
> > > From: Lang Yu <Lang.Yu@amd.com>
> > > 
> > > [ Upstream commit 187916e6ed9d0c3b3abc27429f7a5f8c936bd1f0 ]
> > > 
> > > When using cpu to update page tables, vm update fences are unused.
> > > Install stub fence into these fence pointers instead of NULL
> > > to avoid NULL dereference when calling dma_fence_wait() on them.
> > > 
> > > Suggested-by: Christian König <christian.koenig@amd.com>
> > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > Reviewed-by: Christian König <christian.koenig@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > We start getting this warning spew on chromeos
> 
> Yeah because the older kernels still kept track of the last VM fence in the
> syncobj.
> 
> This patch here should probably not have been back ported.
> 
> Why was that done anyway? The upstream commit doesn't have a CC stable and
> this is only a bug fix for a new feature not present on older kernels.

It is part of the AUTOSEL process.

