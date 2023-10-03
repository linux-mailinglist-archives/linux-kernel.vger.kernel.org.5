Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDEC7B6957
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjJCMrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjJCMre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:47:34 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA73B8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 05:47:31 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7742be66bd3so66269885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696337250; x=1696942050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eUkMz1YjApYBY4q8XnyR26sJ3sHZxbJl6pE8WfOZ43o=;
        b=RXn3AqahD75HG6sn6VYB8PD/Lv1VxvaW2k1S+rBjHeiHv0R6QS1MY/LW5TpNpdgPAl
         zqDerYO5d0VDPt/all232a62m1uKWLaM78bYIykBHR9aYIJr3ASQ2P8pQdnS7JjTNrYK
         u314S+Sw5zpCxmfILSNFyPiKFMnxBf3UShuIkv8fSkwnRzBApQBNpPqQsy33PGy1npFa
         icKZagD3Sg1U4m9/UqK60L21CSptg0vQUYgqs+1/rAjg7V1He3zU5LnTBmcTPppdejlz
         Lf0VoHdKL/y2zR59PLTTWuWN/iQq/XJirQgw1+9lfx1rc4C1EO6w5SGQQTcPSymyopSW
         XL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696337250; x=1696942050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUkMz1YjApYBY4q8XnyR26sJ3sHZxbJl6pE8WfOZ43o=;
        b=E9K2N+vQ5BA/Zu2MCBdhIcLQU8zz+MlrKcnTgQnxn1quq2v+pzZIi6Km64LwSGcQUq
         cCShN6fhoVDemeqVJlGw2bupCeLN7wzNO0FrY2gqfWPolLVk1/oGsM4xdTMQjTp8Cbfq
         U0rXGrscU+KGmHXz2KZmZ69517RCH6QvFyyA0WZqqDNd4vaK1GJfhr3/TZzfDmvISmj2
         a2kDVX58UzV/8JnnVXOOd3RYYHimTaMLniwTp0fSjDSRrFdhSpUZ6FDVCgyKIqZ1P6MY
         4h09++JMFezwimYmNNYaNVMMtJuseIpVACjExQFgpFRUhFo0KdN5hiVapkD0/4xlD5O2
         RZNA==
X-Gm-Message-State: AOJu0Yy2kp69dLQDklhb3X2tE9Zef0sAgd5HdzXYtPVrTFAIHb8ykJng
        JBrfuK6gJ1TBgFfneVzu8w3Ztg==
X-Google-Smtp-Source: AGHT+IFhFWnhz9e/oRrty0zOmjYHb3ht16GyazvZjzXu7zZmdVWPgBoZK/6p/JkRPgFustsN2/J8bg==
X-Received: by 2002:a05:620a:306:b0:76f:11d5:6532 with SMTP id s6-20020a05620a030600b0076f11d56532mr13558305qkm.76.1696337250044;
        Tue, 03 Oct 2023 05:47:30 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id q16-20020a05620a039000b00770f2a690a8sm421173qkm.53.2023.10.03.05.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 05:47:29 -0700 (PDT)
Date:   Tue, 3 Oct 2023 08:47:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 1/3] memcontrol: add helpers for hugetlb memcg
 accounting
Message-ID: <20231003124728.GA17012@cmpxchg.org>
References: <20231003001828.2554080-1-nphamcs@gmail.com>
 <20231003001828.2554080-2-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003001828.2554080-2-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 05:18:26PM -0700, Nhat Pham wrote:
> This patch exposes charge committing and cancelling as parts of the
> memory controller interface. These functionalities are useful when the
> try_charge() and commit_charge() stages have to be separated by other
> actions in between (which can fail). One such example is the new hugetlb
> accounting behavior in the following patch.
> 
> The patch also adds a helper function to obtain a reference to the
> current task's memcg.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
