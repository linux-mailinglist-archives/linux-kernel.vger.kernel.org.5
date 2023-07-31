Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB21768EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGaH33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjGaH3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:29:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AE430D4;
        Mon, 31 Jul 2023 00:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=la9vCumXxx+thsCuV36iYTwTzNB80cwXHoef713V7Qg=; b=T9eeIHYXmNPGSPnCFwtK+zgU5S
        cYk8EAhh0XSe6erfq7j1UKpmPsS9kcrBXf+l/Ak2ctbOmNBk9sXN98ILVoOlMTcQAkKIEdOPYP6GO
        Z/TwuTEP9GafmzL8ZEGwPwlY3WZFsaFT9AJiK3FdbFXq23yC5QHi8o2oqozFKHwUGqLsml94+WLO6
        R1E4oGUSh2BhDM12tZS5E1gvvtQr1+NU2ayqCfUTbcko9SgDl+DwD2igU9ZuQTL7X3YfW/2LFdP6l
        BIeVErVwoSeiQAswK0CXxTM5brhrTfVctrh+Ach/5cx4dcTj5DGFrAJl74mAXW6tuqwwwzvsD3ZI7
        388e3qnw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQNI9-00EJQ7-2D;
        Mon, 31 Jul 2023 07:26:09 +0000
Date:   Mon, 31 Jul 2023 00:26:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jinyoung Choi <j-young.choi@samsung.com>
Cc:     "song@kernel.org" <song@kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2] md/bitmap: Avoid protection error writing bitmap page
 with block integrity
Message-ID: <ZMdiEavzzRwAFjPq@infradead.org>
References: <CGME20230720092957epcms2p6cbd0ecdf7f5bf0db3c04eefaf0a6644d@epcms2p6>
 <20230720092957epcms2p6cbd0ecdf7f5bf0db3c04eefaf0a6644d@epcms2p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720092957epcms2p6cbd0ecdf7f5bf0db3c04eefaf0a6644d@epcms2p6>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 06:29:57PM +0900, Jinyoung Choi wrote:
> Changing the bitmap page is also possible on the page where the DMA is
> being performed or scheduled in the MD.

Are you guys actually using the whacky bitmap feature?  If so, this
really is the least of our problems and you need to invest some real
work into it to get it off ->bmap and into using ->read_iter and
->write_iter.  Right now Song has a series from me queued up to
deprecated it.

I also don't think a simple wait for existing writers prevents you
from other modifications, but maybe I'm issing something.

