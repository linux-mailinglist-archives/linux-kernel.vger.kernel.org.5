Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B5B7ADF41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjIYStG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjIYStF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:49:05 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20847BF;
        Mon, 25 Sep 2023 11:48:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso5276167b3a.0;
        Mon, 25 Sep 2023 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695667738; x=1696272538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwxg1O5NLexfRHctmU+gEL7rjrDGtiPrlMS5U8TZPHY=;
        b=avV/u4GWFcZZx9K3I3wb1EN/+5njxf1JZxwlssDN3I3Mpe/iBjEbVX1XILx8mc003i
         esaO3KirA+zNjJRRVDm5bu6ekgMIGo7iERoCy8dRCeAVQEdkKYIXkk2X7zP3cjqMgrLr
         rl2jkPD1oWspQ4L0dj9K3BKb3ZIg9ZmmfanKtXhA4IvbJ5xz0vr/LoaLjvhLjRjPSsBL
         y9st81RKnDlH0sCxYiM3XuqpwBYOuw2iP6PU0JZDFXDr8lTHwj0LTli4MrBgNZEchobZ
         geFVbqOgWbQIB914q5C5M+SA0VW9sLYDUkNN/Cd3IJarSlpguOBhDd6trDaPSAN/JFBV
         5S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695667738; x=1696272538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwxg1O5NLexfRHctmU+gEL7rjrDGtiPrlMS5U8TZPHY=;
        b=dwbhWRZ3WI9AYUx57vivUEgVHmhBhB5/TFrZiW8gsnNl/TQieaGw0P34j7pIvIujtB
         LdyczPt78KbTZreoUWLPalJOPPffen/m+zinJuSiJo87owhonIiYvUoC8rOhrpQGQhPx
         Vh5PKw7cnF/o1z1fqk0mcA0WTGEqL9RMwZXVRzmdfmJaRCdryr8ZAunLBx5MadQqsNK0
         gR2bWXbxY9HgnsP1vEpnnYMLeek4biwSRXvaKG4j1iG4NZMrQjypOBlqXDasLfv9A2R1
         KUiRwO3Z+Lw/iQ9o3bXt0D2Ib/MHrheC2PiI7GudJJ8994Xq4ZEWUduWCnbsv36f9aSN
         f4dA==
X-Gm-Message-State: AOJu0Yx3CJqfcAYUUJ98vXcuN8Du6Ehdl5oz2rdc7vNkRVDO4PawNwMx
        fr9N6oK+wwUq55ioHlTICpI=
X-Google-Smtp-Source: AGHT+IGERCGUjUKfv0Tc/eNLAzowCTuq0GTxXEhw+pCTKy7DCS377OsWSDQCgeox89Bput5/W9AQAw==
X-Received: by 2002:a05:6a00:2da8:b0:690:c306:151a with SMTP id fb40-20020a056a002da800b00690c306151amr6391818pfb.0.1695667738453;
        Mon, 25 Sep 2023 11:48:58 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:dfcd])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78485000000b00690d1269691sm8365071pfn.22.2023.09.25.11.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:48:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 25 Sep 2023 08:48:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 0/7] Add Open-coded task, css_task and css
 iters
Message-ID: <ZRHWGEqf8tm09jJS@slm.duckdns.org>
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925105552.817513-1-zhouchuyi@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 06:55:45PM +0800, Chuyi Zhou wrote:
> Hi,
> 
> This is version 3 of task, css_task and css iters support.
> Thanks for your review!

From cgroup POV, looks good to me.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
