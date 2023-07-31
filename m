Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00F3769070
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjGaIj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjGaIjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:39:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB9B1AE;
        Mon, 31 Jul 2023 01:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kKpERaVXDKMd33dB8Z6172oH7fQHojYxOewfozLZ6UA=; b=koRyMNYcvjJcXhBaHMwydXCQnm
        x+vQEB+Q5teWiOuoZj514M6zhQnZLud17ppXIay4DvRFSQJaEvq8rHJnz+1vCpOKITaLITXkLJHEO
        EAYUe+R15N1eKMdl2+2+O9gg6j6f3RRiJpW3UBCe1MCVOs4Bx9zrAXYSKVZlEhCWflPFkgFqXp9jy
        7OEuwmt7lri80b9yBHSsuc1ts2I6qjMs85kjOfb1RlmDMGYTgNga5NDHRAp+CD+RXiycBBBZaHXTN
        CEJOfZT+r7rhsFZ4qbGhictyuLXB6JKD9qzhntzmW+AP4TLbiDtlxyvGtc/OaX36xc689Jc55AsRw
        23cT4P6Q==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQOPq-00EYr6-0v;
        Mon, 31 Jul 2023 08:38:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yangbo Lu <yangbo.lu@nxp.com>, Joshua Kinard <kumba@gentoo.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list),
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Subject: require EXPORT_SYMBOL_GPL symbols for symbol_get
Date:   Mon, 31 Jul 2023 10:38:01 +0200
Message-Id: <20230731083806.453036-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series changes symbol_get to only work on EXPORT_SYMBOL_GPL
as nvidia is abusing the lack of this check to bypass restrictions
on importing symbols from proprietary modules.
