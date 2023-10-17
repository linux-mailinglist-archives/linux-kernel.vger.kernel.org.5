Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34E37CCCB1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjJQTzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjJQTzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:55:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC969E;
        Tue, 17 Oct 2023 12:55:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b6f4c118b7so3274617b3a.0;
        Tue, 17 Oct 2023 12:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697572535; x=1698177335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUfAT9j+UiGDkMtqjgkrEGPlSXxDKIe3u0fbK8YKgkE=;
        b=R0buO0NBOBLyjTAs/7inDml0/J2T5CeUDA0SIVLkRSsZ2am6qi8i7xsqay2KEYcyi/
         P27TxtZLXoVCLrv5E3E+08OQytnrfCRaKx/vCAaLaTU5MrhjnL0avYbiHK90L+TmF6sk
         /BtlV3SINPr2my04uKGP6ZvkY04dKIlP8xhPzAdSu8q687mgc5U+ZVkNmQpOFWbb1Lmu
         /b8F5LOhnj4e7vfofnnsUuoU+3IF6ivSvx/5z8X8ZX41gaocNpTPpigWlqAHdQwGueTa
         GKuObFZvUAtIE4JNPFQGyDunFE3NgQps87zeE0yLqKbUNhX7x0wqYDM7ZBiCnFWFRdyz
         PvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697572535; x=1698177335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eUfAT9j+UiGDkMtqjgkrEGPlSXxDKIe3u0fbK8YKgkE=;
        b=ibYCdPD2HX/6344lr0b6fcg1hjUvluda2zUU5PsA1pDtKPEMd7ZPlBqcLTFRLLCKcH
         pWFctBo8sAGX7jv5EUfpBsSIGBmiPd4jYklgEyJQGjEeQSWDW1cn9mLO7I31RlqBwYza
         AOOV1/L3aRXbyBIkbe8P0OwWwlRFvn93gPv6vuWj8aDnsrYdArnSX+qHacEgwuchSVwQ
         R0ogOlTb8w164uAFZ2a05F9lvkXxi/EXsipGRY/gDfLy5WDMA32h7JjHolKo97fg/Dvf
         iVNE2fsD+/Q/4w9YjxFoeBJ+a0jwnr+ZohzlfiQeR/FLXs9+IFH3myEOKytPphbn9mmx
         r9UQ==
X-Gm-Message-State: AOJu0YzGhGfNoToY+Ura1savsLlJRBz1n6SZfZ8/EWZVTCjeh96Fhhs/
        X8YXUdZW9fyTVILeHfFMz+w=
X-Google-Smtp-Source: AGHT+IHpOTr5wIEIVlxb57lkDcxQShrj6O+3bGwiMbh9AQqBmlmlcAGpMNq6jgvSt6NG+sTZrnQKxg==
X-Received: by 2002:a05:6a00:1494:b0:68f:c865:5ba8 with SMTP id v20-20020a056a00149400b0068fc8655ba8mr3770474pfu.18.1697572535241;
        Tue, 17 Oct 2023 12:55:35 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:c77b:3fef:28e3:81d2])
        by smtp.gmail.com with ESMTPSA id a6-20020aa79706000000b0068fece2c190sm1848041pfg.70.2023.10.17.12.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:55:34 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        kjain@linux.ibm.com
Subject: Re: [PATCH V2 0/3] Fix for shellcheck issues with latest scripts in tests/shell
Date:   Tue, 17 Oct 2023 12:55:27 -0700
Message-ID: <169757198796.167943.10552920255799914362.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231013073021.99794-1-atrajeev@linux.vnet.ibm.com>
References: <20231013073021.99794-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 13:00:18 +0530, Athira Rajeev wrote:
> shellcheck was run on perf tool shell scripts as a pre-requisite
> to include a build option for shellcheck discussed here:
> https://www.spinics.net/lists/linux-perf-users/msg25553.html
> 
> And fixes were added for the coding/formatting issues in
> two patchsets:
> https://lore.kernel.org/linux-perf-users/20230613164145.50488-1-atrajeev@linux.vnet.ibm.com/
> https://lore.kernel.org/linux-perf-users/20230709182800.53002-1-atrajeev@linux.vnet.ibm.com/
> 
> [...]

Applied to perf-tools-next, thanks!

