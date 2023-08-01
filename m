Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F6276B297
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjHALDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjHALDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:03:22 -0400
Received: from sxb1plsmtpa01-12.prod.sxb1.secureserver.net (sxb1plsmtpa01-12.prod.sxb1.secureserver.net [188.121.53.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83272D79
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:57:28 -0700 (PDT)
Received: from localhost ([82.27.99.45])
        by :SMTPAUTH: with ESMTPA
        id Qmztq8xXiaXv9Qmzwq8J3c; Tue, 01 Aug 2023 03:53:05 -0700
X-CMAE-Analysis: v=2.4 cv=MIem2uVl c=1 sm=1 tr=0 ts=64c8e412
 a=YwMIiW7BGddQzL8MrqPWMg==:117 a=YwMIiW7BGddQzL8MrqPWMg==:17
 a=L74XCNnjbeE16fMD_K4A:9
X-SECURESERVER-ACCT: atomlin@atomlin.com
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     tj@kernel.org
Cc:     peterz@infradead.org, atomlin@atomlin.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Date:   Tue,  1 Aug 2023 11:53:01 +0100
Message-Id: <20230801105301.952042-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <ZMhFUbL42Ycyc2tI@slm.duckdns.org>
References: <ZMhFUbL42Ycyc2tI@slm.duckdns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEku1gGyOEJmDPlWWnptZeA1+/Jkee3s0tf4F2N0oGVrD8jx4uc+px/jYwDdTDp+bIfn8Bx3Y31yru2Dqdp6uyZjRamynCJBvwHmBFwyEYGXzX91U2Mm
 VhbvPYP8vb3wzdkrTV6K5ghZ/TqTPOdfmcUmm6iubIS++tiigGRPKhP2Kkg1oNEBUkSHrVJ2FXzDJ5elJwxLd8HaHEzcpKCzzOdRtjAKg3jnACQ8uSP+3LHW
 39bKRF/F0wkxLl2dUmHYf2wzaMJ20da3ISC1r8doA6aqFjXsx5/11qPrOVPMTVptSVtPXXC0G3rxGRTU6fW33g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You really shouldn't be setting affinities on kworkers manually. There's
> no way of knowing which kworker is going to execute which workqueue.
> Please use the attributes API and sysfs interface to modify per-workqueue
> worker attributes. If that's not sufficient and you need finer grained
> control, the right thing to do is using kthread_worker which gives you a
> dedicated kthread that you can manipulate as appropriate.

Hi Tejun,

I completely agree. Each kworker has PF_NO_SETAFFINITY applied anyway.
If I understand correctly, only an unbound kworker can have their CPU
affinity modified via sysfs. The objective of this series was to easily
identify a rescuer kworker from user-mode.


Kind regards,
-- 
Aaron Tomlin
