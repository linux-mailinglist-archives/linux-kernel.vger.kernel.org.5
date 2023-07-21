Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597AD75CE1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjGUQSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjGUQRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:17:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB66935AB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:16:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 27BE9218E3;
        Fri, 21 Jul 2023 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689956201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUK7P3ZO1x2I1bIDB8kZYolgZUz6aEcgh0ozIvvNbQs=;
        b=iZu262OPHTDiGGiJbel6yMGQ9JEm3AzzkXhI5jKwJBKYfZc8iKwZKLcS0u7KX7TjzXr0iY
        7C9Ask1+GU1TXbHsWElyQRWOZ0lBMU8Sra4lxY/Tb6d6ZJLPT33IExdEGCeoGT34LaUmru
        2U0bMhLJS2g+pPwo/2jwCm73ukzKgIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689956201;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUK7P3ZO1x2I1bIDB8kZYolgZUz6aEcgh0ozIvvNbQs=;
        b=2UPp+p+vY9ySXvu7MMy/xz06x6W9NkIg3wL7u4te9SbWMDi6/HUlB6V/iVJedS+GXPmZhf
        KnAR4m4gF3cZy2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C8B3134B0;
        Fri, 21 Jul 2023 16:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MIe/AWivumSpQQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 16:16:40 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     chrubis@suse.cz
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jbohac@suse.cz, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it, mgorman@suse.de,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [LTP] [PATCH 1/2] sched/rt: Fix sysctl_sched_rr_timeslice intial value
Date:   Fri, 21 Jul 2023 18:16:36 +0200
Message-Id: <20230721161636.1465036-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719103743.4775-2-chrubis@suse.cz>
References: <20230719103743.4775-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
