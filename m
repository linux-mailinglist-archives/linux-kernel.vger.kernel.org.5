Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B337A61C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjISLzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:55:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F640ED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:55:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9C9C433C8;
        Tue, 19 Sep 2023 11:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695124504;
        bh=UfIzeIdsgnJP3zjEiAb5hOh7YcwEDaTmbm7obV8uCic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+Xi/o1GZhUu+ch+JMi4uIeK/+/yz+7W4M7cqYDF+/7XmpC7G+MhfiEVhXVpVIZvb
         2w6Bo9sUr2cbrOIPNMfjrpbABRjxOkhMzBhmsKWppU02O76sD869kWUQFQt+DSyQef
         D61yOg1HkAHve5zpFT0tNPZ52Kwa8dQHd3JJOBV8=
Date:   Tue, 19 Sep 2023 13:54:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v3 13/13] comedi: add HAS_IOPORT dependencies again
Message-ID: <2023091935-unshaven-compound-fbfe@gregkh>
References: <20230913164013.107520-1-abbotti@mev.co.uk>
 <20230913170712.111719-1-abbotti@mev.co.uk>
 <20230913170712.111719-14-abbotti@mev.co.uk>
 <75212b6925df202fb75357e2e4f4a59d138b7375.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75212b6925df202fb75357e2e4f4a59d138b7375.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 01:40:53PM +0200, Niklas Schnelle wrote:
> On Wed, 2023-09-13 at 18:07 +0100, Ian Abbott wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> > 
> > This was previously done in commit b5c75b68b7de ("comedi: add HAS_IOPORT
> > dependencies"), but that has been reverted because it made it impossible
> > to select configuration options for several comedi drivers.  This is a
> > do-over that avoids that.
> > 
> > Since the original patch, modifications have been made to various comedi
> > modules so that they can still be built even if the port I/O functions
> > have not been declared, so the configuration options for building those
> > modules no longer need to depend on HAS_IOPORT.
> > 
> > Make the COMEDI_ISA_DRIVERS menu option (which allows configuration
> > options for ISA and PC/104 drivers to be selected) depend on HAS_IOPORT,
> > and also depend on ISA || ISA_BUS || PC104.
> > 
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Co-developed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > Cc: Arnd Bergmann <arnd@kernel.org>
> > Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> > Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> > ---
> > v2: N/A.
> > v3: N/A.
> 
> I just gave this another try with the rest of my series including the
> disablement of the I/O port accessors. I tried both allmodconfig and
> allyesconfig on s390x and both seem fine. Also definitely see the
> comedi driver's without HAS_IOPORT dependeny being built.

Great, can we get a tested-by tag for this then?
