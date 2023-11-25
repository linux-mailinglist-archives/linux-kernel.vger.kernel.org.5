Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DD57F8BD3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjKYOsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjKYOsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:48:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32CBAF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:48:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE4AC433C8;
        Sat, 25 Nov 2023 14:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700923709;
        bh=lVV3TZ7xcw4MBjj6Q/YGZ61+1phxV7dz1wIibObBG6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUVq03uzYfCozEemk6AIUEc5HiJWqS4DNi7YWjLHAphQrHSfjJ69gnqlVebPkG5lv
         GkVXql+9UtRCwzeVk/H9e9vGDsEy7fy676YwOq6tlS0OGxnRhIBtXAreoFEs2FUijw
         dzsRASy5mL4q39c2xTqypGpnqhi69eNctWaE24pk=
Date:   Sat, 25 Nov 2023 14:48:26 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 1/6] debugfs: fix automount d_fsdata usage
Message-ID: <2023112519-reprocess-backtrack-0732@gregkh>
References: <20231124162522.16344-7-johannes@sipsolutions.net>
 <20231124172522.01928f127e73.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124172522.01928f127e73.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 05:25:24PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> debugfs_create_automount() stores a function pointer in d_fsdata,
> but since commit 7c8d469877b1 ("debugfs: add support for more
> elaborate ->d_fsdata") debugfs_release_dentry() will free it, now
> conditionally on DEBUGFS_FSDATA_IS_REAL_FOPS_BIT, but that's not
> set for the function pointer in automount. As a result, removing
> an automount dentry would attempt to free the function pointer.
> Luckily, the only user of this (tracing) never removes it.
> 
> Nevertheless, it's safer if we just handle the fsdata in one way,
> namely either DEBUGFS_FSDATA_IS_REAL_FOPS_BIT or allocated. Thus,
> change the automount to allocate it, and use the real_fops in the
> data to indicate whether or not automount is filled, rather than
> adding a type tag. At least for now this isn't actually needed,
> but the next changes will require it.
> 
> Also check in debugfs_file_get() that it gets only called
> on regular files, just to make things clearer.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v2: add missing kfree() pointed out by smatch

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
