Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7D475A06D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjGSVQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGSVQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:16:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133591FCD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 14:16:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5734d919156so1419207b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 14:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689801394; x=1690406194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F9BpFuhMTkAOIbHVpXjSO4oTM9iSvRhAIZS7PoLmzJ4=;
        b=2rWGTRMAxnD6VeFPQEreW2HWSQArB4kLh/AVFJFeMRRu/b0qI1M/YvEqYUK8drstJH
         c/O7qo/G7EcS+Ij4KHSS9CoygJOHy5gj8wp3xmV/RasyNFdsxhTWXIzN3WjKFi628Z7Z
         rIt976xfybkKpbGh6/5efs/pvr+MjFRMYiTTM3VrAUGQ+YfVC370lk74ULcnEvsN3CDB
         NRDaruRhWjr9gF9nA4RyHuIkv2SMzlJxCucuDfduj2L9I5lcjVw2w2ZwfBjwrBYDCZD4
         R2llbtpO92RHOF1V8NVsi+Zl+Wv+rxrxnQsvjkVz34oPQHrkFZaceYSPBoWmhKHdwQq6
         pRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689801394; x=1690406194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9BpFuhMTkAOIbHVpXjSO4oTM9iSvRhAIZS7PoLmzJ4=;
        b=GhPrLK4nuEglrzYF4w5OqCggZRACURc4kBuZK8CTeaYrLRjzQEsCJFsNmtoDFonn9T
         1TxUIlfGnHz/XttLzAFgcFP2jRZi0pAto7NFNI3BVOA/jygbTn0XOSoMHFgsFpeHU06W
         ihiCAG2D+RBlIagzb0SvwaAeOSlfTiPIyej8GAZ2HJKMpc1BTKScGdWsWAkJple3nSJ3
         TD8h86aJGrMXBeM4N9ufm5ertkPKdO7vGueSCd//PniTEKyKNRXGRF/kWJRTveDjNVVC
         YsP1apafWTVD+FYIR0zKgJKRLkYqrV8LYEmJTNISbEtMjcRSraiR2suwI1XeuRs3T95H
         TvTQ==
X-Gm-Message-State: ABy/qLb4Er/RsorR5sKjijsGD/WFtbb2DrLu62AebsZedTT8XXJ97Pz9
        mN4kcAfwqqQYsyIYulkPE8tB1+xlNuqhjq0Vn96c
X-Google-Smtp-Source: APBJJlHreOXAS0H9GQPXpAnmR0dGnAWP0KSY+RuBCP7YUswW95L59jjmKDrqfTpSNj9UEciNANfkAkMJF+8kz9Tkf4LV
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:2c07:36ef:118f:86cf])
 (user=axelrasmussen job=sendgmr) by 2002:a81:430c:0:b0:555:cd45:bc3a with
 SMTP id q12-20020a81430c000000b00555cd45bc3amr198551ywa.9.1689801394300; Wed,
 19 Jul 2023 14:16:34 -0700 (PDT)
Date:   Wed, 19 Jul 2023 14:16:31 -0700
In-Reply-To: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
Mime-Version: 1.0
References: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719211631.890995-1-axelrasmussen@google.com>
Subject: Re: Using userfaultfd with KVM's async page fault handling causes
 processes to hung waiting for mmap_lock to be released
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Dimitris Siakavaras <jimsiak@cslab.ece.ntua.gr>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the detailed report Dimitris! I've CCed the MM mailing list and some
folks who work on userfaultfd.

I took a look at this today, but I haven't quite come up with a solution.

I thought it might be as easy as changing userfaultfd_release() to set released
*after* taking the lock. But no such luck, the ordering is what it is to deal
with another subtle case:


	WRITE_ONCE(ctx->released, true);

	if (!mmget_not_zero(mm))
		goto wakeup;

	/*
	 * Flush page faults out of all CPUs. NOTE: all page faults
	 * must be retried without returning VM_FAULT_SIGBUS if
	 * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
	 * changes while handle_userfault released the mmap_lock. So
	 * it's critical that released is set to true (above), before
	 * taking the mmap_lock for writing.
	 */
	mmap_write_lock(mm);

I think perhaps the right thing to do is to have handle_userfault() release
mmap_lock when it returns VM_FAULT_NOPAGE, and to have GUP deal with that
appropriately? But, some investigation is required to be sure that's okay to do
in the other non-GUP ways we can end up in handle_userfault().
