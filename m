Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84FC808ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443263AbjLGRYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjLGRYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:24:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199CC2D56
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:23:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DA1C433C8;
        Thu,  7 Dec 2023 17:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701969811;
        bh=5ZGbyElS+x41MFLATnYLsznaU+Z7c+doA4GLhjlaIew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dkRZ6y5Qj9QrxhwraMvNrHQbxYNnUc2M2Ws9bbkKt+JuGDa4HmB1BPrV1J0phelDG
         hvhlU7wbIxkEVWP4VkF7WTcgfxvhgSrSPZvgFTvA4zX/pDE/KdKwadzE0oV721g11E
         ek7H2pt91Li8V97BSTov/77ZSTJMs8jy0w7MymYE0uqYM2K6PZzyRku7gN+8ZUimKI
         rP5szN53GaJQQKQwCt3/T1d5tjYYxNmv27cLlPIgl9YgOGPL/5dZVYAWECvSLgXZAy
         jrWDMTAx1RXtudxH21EP4AuhR95sq2kh+jf31AgtqJEJJyT1ZFpijeMAFYIh2r3Stm
         TddQ5Z7LXvelw==
Date:   Thu, 7 Dec 2023 09:23:29 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Aron Silverton <aron.silverton@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231207092329.3ec04dca@kernel.org>
In-Reply-To: <kakenvblxlgrkjvcrwfflnkm6n5fpxgr4qifwkdttjascth3te@57us7mblobjz>
References: <20231128162413.GP436702@nvidia.com>
        <20231128084421.6321b9b2@kernel.org>
        <20231128175224.GR436702@nvidia.com>
        <20231128103304.25c2c642@kernel.org>
        <ZWZJGF7moDM_k6TU@x130>
        <2023112922-lyricist-unclip-8e78@gregkh>
        <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
        <20231204185210.030a72ca@kernel.org>
        <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
        <20231205204855.52fa5cc1@kernel.org>
        <kakenvblxlgrkjvcrwfflnkm6n5fpxgr4qifwkdttjascth3te@57us7mblobjz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 10:41:25 -0600 Aron Silverton wrote:
> > I understand that having everything packaged and shipped together makes
> > life easier.  
> 
> I think it is a requirement. We operate with Secure Boot. The kernel is
> locked down. We don't have debugfs access, even if it were sufficient,
> and we cannot compile and load modules. Even without Secure Boot, there
> may not be a build environment available.

This 'no debugfs' requirement is a kernel lockdown thing, I presume?
Are we expected to throw debugfs out the window and for all vendors
to reimplement their debug functionality via a misc driver taking
arbitrary ioctls? Not only does that sound like a complete waste of
time and going backward in terms of quality of the interfaces, needing
custom vendor tools etc. etc., but also you go from (hopefully somewhat)
upstream reviewed debugfs interface to an interface where the only
security assurance is vendor telling you "trust me, it's all good".
