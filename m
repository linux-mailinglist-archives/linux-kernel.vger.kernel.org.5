Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7E87FA4CC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjK0PeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjK0PeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:34:01 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4803E194
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:34:08 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-db35caa1749so3878745276.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701099247; x=1701704047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SFx0sc6Fj7zTpNP/EH1BCuEJYwxztRxRLD5/S1r93r8=;
        b=EJQVOyWbKB03Obo5GuSga/z4V6NEe/f0NJbKy72HcMCepfAA+7fTRe6nr43uD9SQTu
         GzCvKm1Umv9CXhAHxagW4geXDclg1+BhV8blWbG1+a4Nxrg6IRXTZ+9ZttyYVD6K9MiG
         VaUC6LZOp9A/CXbP7TZ45LWpqLOipqdQQKHjMm1Ht9Qy7eb51GcPSKMG7sbxNMqLNPBC
         RIduAo6u+BuwjhQQy1S7YRox/tzeocdRrq1ySStq4PeEvGaVHwIHCbVdOqFFkOif2f0o
         o5DK3VMNelpncOS+PmWjHHwXxrkpxsdZHI4f1tCPIaHthzo3TkKMZpL410BmUrlpETFR
         47Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701099247; x=1701704047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFx0sc6Fj7zTpNP/EH1BCuEJYwxztRxRLD5/S1r93r8=;
        b=vgEde0oeN1hlxuNiFWcAVoIU9zd30t3s6RaCM1SLmTJnbP3UBqP3RsatGbMhNnaral
         tolwulqQhu/Kj+Wx3xXjkIUoJU9aRQ/VbSucMmU2P36JPPVmpkmMJZdf89NT0vy5xfG2
         SrJY4l/gXSQPrfGgS7MlkM74/T4q1n0KZROOkfyvSkwqbvJGSydWW+9fNmXDdtymQfSy
         /bW+clJhzotgNf+WEW/GSHSKatDhAMC50bV99hdK+J2VJ9vwF2O7D12aoIgMF7KBXUhh
         G5bVzBOJUj5ri0bu/YcL+OFuBCbIt1v3xRMRQ5srf9r/3+/uBpVQQ5Q57ds5NAWqa7x0
         gOTw==
X-Gm-Message-State: AOJu0YySHzvj6v+WbNSPQd+gjkYCF/gjgh6lDi9QrlFr8xBCVQ+fG9MA
        hJj3s/kHlj+CUHJtONT8Z8tHPk//87vQYlfWeGs8Wg==
X-Google-Smtp-Source: AGHT+IECWCNmNCMvrUC/Cox/cF+UvUcCK5NPLIgBFNDdNQlG+5aAkL/8V/fSkjS9V1TFGTlqeAhsidRO+Bb1mFvKJTI=
X-Received: by 2002:a25:8e85:0:b0:d9d:8fb:d29f with SMTP id
 q5-20020a258e85000000b00d9d08fbd29fmr11180276ybl.45.1701099247369; Mon, 27
 Nov 2023 07:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20231127135033.136442-1-ulf.hansson@linaro.org> <ZWSwQklU0MFQLMeI@bogus>
In-Reply-To: <ZWSwQklU0MFQLMeI@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Nov 2023 16:33:31 +0100
Message-ID: <CAPDyKFr=EUuKBqzjV4Uio8LWXemC+sPC9im44HLFNLEiZGc9Fg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: Avoid polling for scmi_perf_domain
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 at 16:05, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Nov 27, 2023 at 02:50:33PM +0100, Ulf Hansson wrote:
> > It was a mistake to prefer polling based mode when setting a performance
> > level for a domain. Let's instead rely on the protocol to decide what is
> > best and thus avoid polling when possible.
> >
> > Reported-by: Nikunj Kela <nkela@quicinc.com>
> > Fixes: 2af23ceb8624 ("pmdomain: arm: Add the SCMI performance domain")
>
> Ah, I hadn't even noticed before  :). Anyways,
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks, applied for fixes!

Kind regards
Uffe
