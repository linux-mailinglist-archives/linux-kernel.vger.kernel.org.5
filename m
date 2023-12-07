Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76323808ACB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443268AbjLGOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjLGOiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:38:04 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73227B9;
        Thu,  7 Dec 2023 06:38:10 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4CA62669;
        Thu,  7 Dec 2023 15:37:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701959847;
        bh=zXe+jRGFsIALQDiNPjUbby+TY+TBluHe2uMVYoZajGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFvfub1kMNWT+sajOcN5s7Ix3DNF2A6Pkg5dQ9Y7g9Coz6OmKJnCPKj2yL9gUCwUK
         8mnLCDDOxUytTLxkyTZeJGqrH5UF7H7W1qtp4hNUzgp15DJZLkbLfPcGsN6exWkTrZ
         O1MzrHNjifnFuxyRI9lkqoozUdRpBmc8Z61b/zJ0=
Date:   Thu, 7 Dec 2023 16:38:14 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Simon Glass <sjg@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Tom Rini <trini@konsulko.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
Message-ID: <20231207143814.GD15521@pendragon.ideasonboard.com>
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com>
 <20231207142723.GA3187877@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207142723.GA3187877@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrote:
> On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > Thank you for the patch.
> > 
> > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > Add a script which produces a Flat Image Tree (FIT), a single file
> > > containing the built kernel and associated devicetree files.
> > > Compression defaults to gzip which gives a good balance of size and
> > > performance.
> > > 
> > > The files compress from about 86MB to 24MB using this approach.
> > > 
> > > The FIT can be used by bootloaders which support it, such as U-Boot
> > > and Linuxboot. It permits automatic selection of the correct
> > > devicetree, matching the compatible string of the running board with
> > > the closest compatible string in the FIT. There is no need for
> > > filenames or other workarounds.
> > > 
> > > Add a 'make image.fit' build target for arm64, as well. Use
> > > FIT_COMPRESSION to select a different algorithm.
> > > 
> > > The FIT can be examined using 'dumpimage -l'.
> > > 
> > > This features requires pylibfdt (use 'pip install libfdt'). It also
> > > requires compression utilities for the algorithm being used. Supported
> > > compression options are the same as the Image.xxx files. For now there
> > > is no way to change the compression other than by editing the rule for
> > > $(obj)/image.fit
> > > 
> > > While FIT supports a ramdisk / initrd, no attempt is made to support
> > > this here, since it must be built separately from the Linux build.
> > 
> > FIT images are very useful, so I think this is a very welcome addition
> > to the kernel build system. It can get tricky though: given the
> > versatile nature of FIT images, there can't be any
> > one-size-fits-them-all solution to build them, and striking the right
> > balance between what makes sense for the kernel and the features that
> > users may request will probably lead to bikeshedding. As we all love
> > bikeshedding, I thought I would start selfishly, with a personal use
> > case :-) This isn't a yak-shaving request though, I don't see any reason
> > to delay merging this series.
> > 
> > Have you envisioned building FIT images with a subset of DTBs, or adding
> > DTBOs ? Both would be fairly trivial extensions to this script by
> > extending the supported command line arguments. It would perhaps be more
> > difficult to integrate in the kernel build system though. This leads me
> > to a second question: would you consider merging extensions to this
> > script if they are not used by the kernel build system, but meant for
> > users who manually invoke the script ? More generally, is the script
> 
> We'd also be interested in some customization, though in a different way.
> We imagine having a rule file that says X compatible string should map
> to A base DTB, plus B and C DTBO for the configuration section. The base
> DTB would carry all common elements of some device, while the DTBOs
> carry all the possible second source components, like different display
> panels or MIPI cameras for instance. This could drastically reduce the
> size of FIT images in ChromeOS by deduplicating all the common stuff.

Do you envision the "mapping" compatible string mapping to a config
section in the FIT image, that would bundle the base DTB and the DTBOs ?

> > meant to be used stand-alone as well, in which case its command line
> > arguments need to remain backward-compatible, or do you see it as being
> > internal to the kernel ?
> 
> [...]
> 
> ChenYu

-- 
Regards,

Laurent Pinchart
