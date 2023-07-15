Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9434B754717
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 08:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGOGiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 02:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGOGiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD1A358E;
        Fri, 14 Jul 2023 23:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 508B5600BE;
        Sat, 15 Jul 2023 06:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CACC433C7;
        Sat, 15 Jul 2023 06:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689403096;
        bh=uRlIl+vbdu2QDLuqivP4y8zF+71MOCAvYoUKfpnosCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucZdyl0ekP17LSlYQl20XnwxkfjrKusvXBqL5aS3aQ7EOagl3MTDzTh7nTZvtDm3G
         7wjEP//NUajY+2c+mvFIPoX1SPB91hbDrX7U/4ybPVKxFKRrE1rwT/k4fBX8+Ksg/a
         E5gpVu//lE0YohivXiMBMt9B3VZ88wBINLN8SrQA=
Date:   Sat, 15 Jul 2023 08:38:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     corbet@lwn.net, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH docs] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <2023071542-startup-everyone-eb5d@gregkh>
References: <20230713223432.1501133-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713223432.1501133-1-kuba@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 03:34:32PM -0700, Jakub Kicinski wrote:
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
> 
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Please consider this more of a draft than a statement of my opinion.
> IOW prefer suggesting edits over arguing about correctness, hope
> that makes sense.

This looks great to me, thanks for putting it together.

But I do have one objection on the timeline portion:

> ---
>  .../feature-and-driver-maintainers.rst        | 159 ++++++++++++++++++
>  Documentation/maintainer/index.rst            |   1 +
>  2 files changed, 160 insertions(+)
>  create mode 100644 Documentation/maintainer/feature-and-driver-maintainers.rst
> 
> diff --git a/Documentation/maintainer/feature-and-driver-maintainers.rst b/Documentation/maintainer/feature-and-driver-maintainers.rst
> new file mode 100644
> index 000000000000..ee8ccc22b16a
> --- /dev/null
> +++ b/Documentation/maintainer/feature-and-driver-maintainers.rst
> @@ -0,0 +1,159 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================
> +Feature and driver maintainers
> +==============================
> +
> +The term "maintainer" spans a very wide range of levels of engagement
> +from people handling patches and pull requests as almost a full time job
> +to people responsible for a small feature or a driver.
> +
> +Unlike most of the chapter, this section is meant for the latter (more
> +populous) group. It provides tips and describes the expectations and
> +responsibilities of maintainers of a small(ish) section of the code.
> +
> +Driver and alike most often do not have their own mailing lists and
> +git trees but instead send and review patches on the list of a larger
> +subsystem.
> +
> +Responsibilities
> +================
> +
> +The amount of maintenance work is usually proportional to the size
> +and popularity of the code base. Small features and drivers should
> +require relatively small amount of care and feeding. Nonetheless
> +when the work does arrive (in form of patches which need review,
> +user bug reports etc.) it has to be acted upon very promptly.
> +Even when single driver only sees one patch a month, or a quarter,
> +a subsystem could well have a hundred such drivers. Subsystem
> +maintainers cannot afford to wait a long time to hear from reviewers.
> +
> +The exact expectations on the review time will vary by subsystem
> +from 1 day (e.g. networking) to a week in smaller subsystems.

"to a few weeks".

I can't do 1 day, or even 1 week for the subsystems I maintain
(especially during merge windows or vacations.)  How about that line
being:
	from 1 day (e.g. networking) to a few weeks for smaller subsystems.

And then add a link to "For specific subsystem response times, please
see the document in [insert link here to where we keep the subsystem
expectations]"

And yeah, I do need to go add some process/maintainer-* files for the
subsystems I maintain, it might be a good idea to also say that any new
subsystems also provide this so we can start catching up on that.

thanks,

greg k-h
