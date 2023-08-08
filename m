Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1321377414D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjHHRR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjHHRR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:17:26 -0400
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net (p3plsmtpa08-10.prod.phx3.secureserver.net [173.201.193.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15AA71F35
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:07:06 -0700 (PDT)
Received: from localhost ([82.27.99.45])
        by :SMTPAUTH: with ESMTPA
        id TKp4q2cgcSiNMTKp5qBcro; Tue, 08 Aug 2023 04:24:23 -0700
X-CMAE-Analysis: v=2.4 cv=L8fbAcf8 c=1 sm=1 tr=0 ts=64d225e7
 a=YwMIiW7BGddQzL8MrqPWMg==:117 a=YwMIiW7BGddQzL8MrqPWMg==:17
 a=zbEXTGt8dRSy2PkKq4cA:9
X-SECURESERVER-ACCT: atomlin@atomlin.com
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     tj@kernel.org
Cc:     atomlin@atomlin.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH] workqueue: Rename rescuer kworker
Date:   Tue,  8 Aug 2023 12:24:21 +0100
Message-Id: <20230808112421.3390505-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <ZNFxmnGHxV0z5gKA@slm.duckdns.org>
References: <ZNFxmnGHxV0z5gKA@slm.duckdns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIT1eybOuCnkoI6fym4VG5UVHqPruL3t0yIpAEkFBM34hzmtj4soLYoZ0fIZK3dq6EhcZZl+xVnDUtg8bU6fs1oWh5ptQxW3Z2afmneGgytYYTSdrotT
 qWxNN8EqLf2zdPAKf7LUtQrSWdfhPvBr4W5TjTGZOqAupDGafe+VJZrrm6mZY16GJ0Hwp6fccUpwxsq0VMOqpk42HLliFx5AcXeRhvi1HtuZ+6xWFfauQlGN
 t9xNqHPipAu7vLod3kaPPbJmsoUaFuef1w1vmJ7zT2UYZAT82Noln8nvditkYYB9CJtFHoLibrhmtPtfpZZLcA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not necessarily against the rename but you can't, or at least
> shouldn't, modify the cpu affinity of any workqueue worker. You don't
> know what that worker is going to be executing even at the moment when
> the cpu affinity change is committed, let alone in any future. Can you
> please drop that part from the patch description? It doesn't make a lot
> of sense.

Hi Tejun,

Understood - will do. Initially, I wanted to stress the point that
user-mode should not pay any attention to a rescuer kworker's CPU affinity
since by design it can run on any possible CPU.
According to housekeeping_setup() and workqueue_init_early(), if I
understand correctly, when kernel parameter nohz_full is set then each
unbound kworker is not permitted to execute on any CPU in the specified
range i.e. the unbound workqueue cpumask is set based on the housekeeping
cpumask only. So, that's good enough.


Kind regards,

-- 
Aaron Tomlin
