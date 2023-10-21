Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB447D19F9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjJUAiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjJUAis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:38:48 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBE4D6E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:38:45 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c7a4735a30so249216a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697848725; x=1698453525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=423X7bf3mKdV2TfpiLpGt3onIWyjL6GRNCUQJNzFbJY=;
        b=GCPt+Mr41cq8TzswR0amE3zshzM9Nlas9+I4pUIA+1qBSHqfuoyG8qdeSePaM70SK+
         ga/J4yau0grKFwXeCIfUfUpRnAcJ3AKKgxJIoFgbuWbyOGKOUm4/kwOO9h1s4fIsRsDz
         ajY3TGF7x4n64DypEAndW86jd3361xl12mf9uXaUxbaNXaxsbztkOkbHA7XvoWh8L8V7
         oF8wv35OlpUcoQemrvBfBEOxhMLX/csUHhXXKYQj2pFgHwAPEkQ8Vb1OVVE4hR+AfJrm
         JSU8EgTs9ZLSTnDBkFtsG5DwOp+RyUrXZDAQ2fZ89xp3hfinEkuSJxTr+63XAEVS9cD4
         CMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697848725; x=1698453525;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=423X7bf3mKdV2TfpiLpGt3onIWyjL6GRNCUQJNzFbJY=;
        b=PpqcgnbDkZoIhzKDV1+qUlLNcjOdsqpZjY6i6W+E5NGTEoP7TjWUXBnsRh8HPgX/3z
         6VdiOTfZVtFVVyecfJAEuw09BbRuHD7VcEIa2KjXgbvdrN5vxok8UJBA0HKO3gaDd2Ur
         7m9c59K8W8KSM4ngo4oUBIPdW2xGbi27G2spnLj81CO4zMmGVWtK9uQgB+Um//mCk4nD
         EiUqKBbSBYXu+XAIr4TgprroyEC6nrMcFvhsnM8YASvPTuAFRn00JHgDNJjEVT68NHxX
         VL5pvdsIegmP+i0qbcVqGbW2ELzwk06f7V3VGO+XoFy0E8wHTz9ZD1O0zLzXZH/i0S0x
         Hwbw==
X-Gm-Message-State: AOJu0YyusjHiRQdQOjkMVkqHiFnTvNYetDuAQSGC6AU7cldwKApIZlCZ
        b5eahQ4SIjk7G56D4to3YN/cRA==
X-Google-Smtp-Source: AGHT+IGdv9UkTnlXLx/5ijBTQR2xHsaXZ87/AXJ/nw5vxj4PW5/dpIBr4LcagbwlUR9FnNBJNYtfhg==
X-Received: by 2002:a9d:51d2:0:b0:6bf:500f:b570 with SMTP id d18-20020a9d51d2000000b006bf500fb570mr3774295oth.3.1697848725192;
        Fri, 20 Oct 2023 17:38:45 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:984c:2fe2:e7f8:bd24:713c:c8fb])
        by smtp.gmail.com with ESMTPSA id h6-20020a9d61c6000000b006cd33d6fd5csm520636otk.11.2023.10.20.17.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 17:38:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Khazhismel Kumykov <khazhy@chromium.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        oleg@redhat.com, linan122@huawei.com,
        Khazhismel Kumykov <khazhy@google.com>
In-Reply-To: <20231020223617.2739774-1-khazhy@google.com>
References: <20231020223617.2739774-1-khazhy@google.com>
Subject: Re: [PATCH] blk-throttle: check for overflow in
 calculate_bytes_allowed
Message-Id: <169784872374.3020638.17698696801548218359.b4-ty@kernel.dk>
Date:   Fri, 20 Oct 2023 18:38:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Oct 2023 15:36:17 -0700, Khazhismel Kumykov wrote:
> Inexact, we may reject some not-overflowing values incorrectly, but
> they'll be on the order of exabytes allowed anyways.
> 
> This fixes divide error crash on x86 if bps_limit is not configured or
> is set too high in the rare case that jiffy_elapsed is greater than HZ.
> 
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: check for overflow in calculate_bytes_allowed
      commit: 2dd710d476f2f1f6eaca884f625f69ef4389ed40

Best regards,
-- 
Jens Axboe



