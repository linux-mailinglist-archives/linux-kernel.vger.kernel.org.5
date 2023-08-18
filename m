Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC927805D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357987AbjHRGGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357999AbjHRGGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:06:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F413A99
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:05:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63DF763C7B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64765C433C7;
        Fri, 18 Aug 2023 06:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692338758;
        bh=n3BpoIeXq9CIvchSKrnmLWQgVA9pvqrLHqMRQFzVdPM=;
        h=From:Subject:Date:To:Cc:From;
        b=qf6UYoy4G2GFHC+FPZaU6nW5AW6/PaBH31SVWSJYJuhaqcz7kM98evR3UgnTRSvg+
         P7J25H25cjWWjZ2VhobHehDhYHip9S+h7x5eqG21ZfX0AgPJ0rtORj+Slfqr6yDld7
         BRe3hylKMZymiiMxU+D18Ywo2uR837j9htNLywdhYRaeXOe89+D2PRsrz58xhHLJSb
         AkKDgAC7eChRLps+5OBOws9Qx4H+VKxR14Vwk3dznINlpPqKciTQunaZ7ZwUdO8tuu
         nxDABbxQMRoH4rf7H0Yrqc616qIqYFAu4naHvmxIZ/h4fSgN+HxwlkG2lu4CVK3409
         N+RFoIkhD0iZQ==
From:   Chris Li <chrisl@kernel.org>
Subject: [PATCH RFC 0/2] mm/page_alloc: free_pcppages_bulk safeguard
Date:   Thu, 17 Aug 2023 23:05:22 -0700
Message-Id: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACMK32QC/x2NQQqDMBQFryJ/3YCxUKXbQg/QbSnyE180VGPIr
 1IQ797Y5TAMs5EgeQhdi40SVi9+Dhn0qSA7cOihfJeZqrI6l42ulUtAG22M3ENas4xv5dha3XQ
 XB9SUQ8MCZRIHOxzpNCn5sBlxuJjg/Pc/fNLjfqPXvv8AU1Y79oUAAAA=
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, Michal Hocko <mhocko@suse.com>,
        david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
        Namhyung Kim <namhyung@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        Chris Li <chrisl@kernel.org>,
        John Sperbeck <jsperbeck@google.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch series I want to safeguard
the free_pcppage_bulk against change in the
pcp->count outside of this function. e.g.
by BPF program inject on the function tracepoint.

I break up the patches into two seperate patches
for the safeguard and clean up.

Hopefully that is easier to review.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
Chris Li (2):
      mm/page_alloc: safeguard free_pcppages_bulk
      mm/page_alloc: free_pcppages_bulk clean up

 mm/page_alloc.c | 44 +++++++++++++-------------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)
---
base-commit: 5fb2ea3111f4ecc6dc4891ce5b00f0217aae9a04
change-id: 20230817-free_pcppages_bulk-facc18d6fee7

Best regards,
-- 
Chris Li <chrisl@kernel.org>

