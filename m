Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6094B75CDFA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjGUQQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjGUQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:16:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA334698
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:15:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C9B33218E3;
        Fri, 21 Jul 2023 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689956117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=893DSRE7aZ9gu/OfUgulkNpFt1xhMXrfw3y4j2G2d9Q=;
        b=BIipULa5IOiQjk4WwVVyFAF5F6d6VUa/o0v901Qp+578EPwwXtipDh+us6QAkmjQ5gstkD
        7J8kAFRulTDQnT9gK/QB1GeY3wOr5BLywlcOit30oDNKUEUuCvjynP0IL9U/dE2erWoKEm
        HWycEgrWFhcd2moBg8wKBzNZD9+aTcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689956117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=893DSRE7aZ9gu/OfUgulkNpFt1xhMXrfw3y4j2G2d9Q=;
        b=3Epz6gTAwWYt8ffUV0atgGDLg7iNrz8o6ImVu7s4C/AjJX77/yFKTcnULEHHqiVP4EFxGX
        z3zaFFXoKGsLClBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2367E134B0;
        Fri, 21 Jul 2023 16:15:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XVvMBBWvumQaQQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 16:15:17 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     chrubis@suse.cz
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jbohac@suse.cz, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it, mgorman@suse.de,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH 2/2] sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
Date:   Fri, 21 Jul 2023 18:14:58 +0200
Message-Id: <20230721161458.1464841-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719103743.4775-3-chrubis@suse.cz>
References: <20230719103743.4775-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
