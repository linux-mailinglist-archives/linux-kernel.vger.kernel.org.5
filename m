Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DCF7E21D9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjKFMgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjKFMgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:36:11 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36C9BD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 04:36:08 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a822f96aedso52731857b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 04:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699274168; x=1699878968; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VJDUivzyJwXlqL5M091869BzocP1uyzJFbwtw7gtmyI=;
        b=n93W4TnmXfrquQ1mFVO0lpT4bmOFN8EQYJmZyzH1qj35in4fkxhxkdFYpbwSw5jShh
         cTo2NCtMdrDjY4PxOVpEQ6ZzHUr0fQdnp1sMxmyFRnNzgJi2U7PtOGoeyfCzPxjS7sig
         QgbmuLS91qWzeTofIZM+bucqkHema413soikx9FbjwbrKt9oK8pG7jplq7P1nepvxZFr
         IK37XM9Sx/++WeTaQIP2KrCrGDLI0QR127fv0s57tzPEzKhlDgB3bsENSko+PfGEwFJN
         +ELTbAvlmzfq+Yn8ibzt6GbL8is1qEC2NYW7B7QlG835GtkUcRHm+1cW+2VukOEB8XCe
         dJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699274168; x=1699878968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJDUivzyJwXlqL5M091869BzocP1uyzJFbwtw7gtmyI=;
        b=makErESalayHaQl7L+GntODwhhvDcuBmOy2uDksPKc5vhthk7wfrd2UCUKX7eFDJpD
         xAccDQsf3sZT1vFmdcLHrnHCRtsTbzoHJStEjHQdSaEVHjpVr3vE044MvVIuGnJSTMMS
         avYYcnw00P2kjhj2K4U8g4tGk1BQDUQdP3kR7EpEjHGwAAFmLrFAiJGRIR+ABaAwxFda
         KWksktdQeJAT+Zb/TjK4AwxCS9N5lxovWuImMtICRhtVBA4szBrJnQskqUZIvTqgyFJV
         KimaaA5d+N08WZSg3UocNixpfczngNGmH4GHj4mIq3hvKOvLVQyyFwvsonNTmsSBf0aC
         8N5A==
X-Gm-Message-State: AOJu0YxUOkXQNBUo0Z7wl5axqSrtz+n/A+BEsZm5ifARo5kX6Scp9taA
        uiIe3SeAlCfDqvqAhQQhF/2VB85hUnZg/Kf/gMChOQ==
X-Google-Smtp-Source: AGHT+IGhS2m7ZE2zGAOmmnn1e6cpTmJkjwjC9JdnNOFUffxfIaqaxIrJ5/28oPGlMryE9W1BYGXDofXV+sJNA0Q6mr4=
X-Received: by 2002:a81:6d11:0:b0:58f:a19f:2b79 with SMTP id
 i17-20020a816d11000000b0058fa19f2b79mr11127022ywc.9.1699274167864; Mon, 06
 Nov 2023 04:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20231106-pm8937-v1-0-ec51d9eeec53@riseup.net> <20231106-pm8937-v1-3-ec51d9eeec53@riseup.net>
In-Reply-To: <20231106-pm8937-v1-3-ec51d9eeec53@riseup.net>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 6 Nov 2023 14:35:56 +0200
Message-ID: <CAA8EJprJQMMPwtZQ5AMB=SLA0YhT7pYORNaAqAopZxS2nRu3EQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] regulator: qcom_spmi: Add PM8937 SPMI regulator
To:     Dang Huynh <danct12@riseup.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 at 14:19, Dang Huynh <danct12@riseup.net> wrote:
>
> The PM8937 has 4 HFSMPS, 2 FTSMPS2.5 (for controlling APC voltage)
> and 23 LDO regulators.
> Add the configuration for this chip.
>
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  drivers/regulator/qcom_spmi-regulator.c | 34 +++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



--
With best wishes
Dmitry
