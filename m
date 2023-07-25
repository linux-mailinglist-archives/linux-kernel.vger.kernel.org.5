Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36912761E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGYQLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGYQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:11:47 -0400
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [46.30.211.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9320497
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Cw0rSgWDkapwKrtV1yb4DAXkoD6Qi6nW+7bK2LlKxI8=;
        b=LMuii0YUL0u0Nz6ZDEctnWCfXXVz2diSZuExElJK8e80DmVxgQ2oRlDtxJ+BX+lqC8FQj6DC4b14j
         RkQMAtexvHYe56elwXmC6IzLpevK/TArH0WUT8L2M1SUCjKdAt7nhJgf6hG1CYTt7BL0yhYyZlbUO2
         2KHvdET1w7UEJ0BaU4Vm8hQBwMWfJPW6kWw9bs9pYhFihQeiVsMqwcfdWL7Gbqe5deuNoxOEfnG9mO
         2EKIzP7MJdi1BV1KSk9JFvihu3TeUhmOu5QTZcNQUXeoaEJhsxr224Or+EwMbU7f/7xV/9nNlpeFup
         aecFEqNGyZtwdoObVZqVQ1ivVfBjEMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Cw0rSgWDkapwKrtV1yb4DAXkoD6Qi6nW+7bK2LlKxI8=;
        b=6udjONwzC4RS6UCDRwuB0jT3P0S272OHqJSZGbjhVLdf+Grie/fQntnVOmdERgC/I33l0gCQh2m4L
         bYY5YZUBw==
X-HalOne-ID: cc724f5c-2b05-11ee-a82b-55333ba73462
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id cc724f5c-2b05-11ee-a82b-55333ba73462;
        Tue, 25 Jul 2023 16:10:42 +0000 (UTC)
Date:   Tue, 25 Jul 2023 18:10:40 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux@treblig.org
Cc:     davem@davemloft.net, benh@kernel.crashing.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sparc: Use shared font data
Message-ID: <20230725161040.GA832394@ravnborg.org>
References: <20230724235851.165871-1-linux@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724235851.165871-1-linux@treblig.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 12:58:51AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> sparc has a 'btext' font used for the console which is almost identical
> to the shared font_sun8x16, so use it rather than duplicating the data.
> 
> They were actually identical until about a decade ago when
>    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
>                         "broken bar" to "vertical line"")
> 
> which changed the | in the shared font to be a solid
> bar rather than a broken bar.  That's the only difference.
> 
> This was originally spotted by PMD which noticed that PPC does
> the same thing with the same data, and they also share a bunch
> of functions to manipulate the data.  The PPC code and the functions
> I'll look at another time if this patch is OK.
> 
> Tested very lightly with a boot without FS in qemu.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Looks good, thanks for the fixes.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Let's hope someone picks it up...

	Sam
