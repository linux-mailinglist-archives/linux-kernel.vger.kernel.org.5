Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614CD7BBAFE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjJFO6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjJFO6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:58:47 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D98A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:58:46 -0700 (PDT)
Received: from localhost (unknown [176.59.162.175])
        by mail.ispras.ru (Postfix) with ESMTPSA id F2AEF40AC4FC;
        Fri,  6 Oct 2023 14:58:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru F2AEF40AC4FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1696604323;
        bh=zZyzh/Wh062f7c3Pw72ZP1LjORx/TUbNNL9pBnx3IHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGwvyiTcJ+S7nXsfw+yGpzN82Io1YNvYzzMhEJvDFESLdGo1JnCxBS5Ow+rnAVJHA
         Y17S495KNJrSmdRFRauK6uANBHgq1wX5el2eAzEaEqDxP05eKRQAZRZ7+wyc9g7ySH
         v2075D6sZr8eINFOwb0AgzoPzBZ3hcdkU6HLDWjw=
Date:   Fri, 6 Oct 2023 17:58:35 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Stone <daniels@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] drm/crtc: do not release uninitialized connector
 reference
Message-ID: <3rrycldn3ssrqqyiowv3ariqigfonddps6d34zjquzar6fahtc@ozy6jqnaiq3c>
References: <20230721101600.4392-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721101600.4392-1-pchelkin@ispras.ru>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/21 01:15PM, Fedor Pchelkin wrote:
> Inside drm_mode_setcrtc() connector_set is allocated using kmalloc_array()
> so its values are uninitialized. When filling this array with actual
> pointers to drm connector objects, an error caused with invalid ioctl
> request data may occur leading us to put references to already taken
> objects. However, the last elements of the array are left uninitialized
> which makes drm_connector_put() to be called with an invalid argument.
> 
> We can obviously just initialize the array with kcalloc() but the current
> fix chose a slightly different way.
> 
> The index of failing array element is known so just put references to the
> array members with lower indices.
> 
> The temporary 'connector' pointer seems to be redundant as we can directly
> fill the connector_set elements and thus avoid unnecessary NULL
> assignments and checks.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: b164d31f50b2 ("drm/modes: add connector reference counting. (v2)")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

I'm sorry for bothering everyone with this issue, but status of the patch
here [1] is still 'New', and I have no means to deduce whether the
subsystem maintainers didn't have time to review (it is totally
understandable as the amount of patches is enormous) or the patch was
missed somehow.

[1]: https://patchwork.kernel.org/project/dri-devel/patch/20230721101600.4392-1-pchelkin@ispras.ru/
