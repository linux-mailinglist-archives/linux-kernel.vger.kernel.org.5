Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134EA7F15D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjKTOiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKTOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:37:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB76113
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AzLMHqY7qEz2pgaGraffiJ/GjZASqgIcYbmgvz0+q3g=; b=sVsdZb9ojcx+HaK8Nh0ZVDZYd2
        3iKpWF9JUJLgF6u/tn1cP4OOaqYuEw67l6i7lLveQ0CloAKZKXPsi7uq+As+7+CK1LEr/moi36Df/
        dVhPWoCKQdOUtH+ALB2sQyvwa0pXeXn8oHbUH+LEQGf+HM6FK0KFKEvKquXf+76c9WfCF8GNpmMp2
        z0NqoXgD+8oeMPvTm4hAWuN8EDe9BKzDV+RFQllZB855uj4sVc2YJxsgCZftgNLyiJh//+yY6NtAW
        D87pSnyJxWE7wz/cJtzAumTF8nQ6rAbeK1irTNup3okovJX8k12Wf77DlJ/OQWiFjec/qWQU55sQW
        PtYCvMxA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r55PM-004dy7-7h; Mon, 20 Nov 2023 14:37:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id CE868300419; Mon, 20 Nov 2023 15:37:51 +0100 (CET)
Message-Id: <20231120143344.584345121@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 20 Nov 2023 15:33:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 0/2] x86/entry: Trade cycles
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Two little patches that trade a little performance. First patch optimizes
(although I couldn't get definite numbers showing it makes a difference) the
return to user path by avoiding some PTI specifics in the generic path.

Second patch then steals some of the won cycles by making a debug check
unconditional.

This came forth from a discussion with amluto who lamented we only had the
debug check conditional on DEBUG_ENTRY.


