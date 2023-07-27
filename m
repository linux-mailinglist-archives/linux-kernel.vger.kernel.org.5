Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CC776599E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjG0RMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjG0RL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:11:59 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B4D272D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:11:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686f25d045cso702323b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690477918; x=1691082718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1q7JLoG0EiFt7LGAh9L3HylZSzybbb6OAkvvFe4ftDc=;
        b=HMb1/rptSlTgUqX2b5CIcoF7PAnhYDjfpgPoEj+bhdRfheWle/hDoqOuIwgbUSJZKM
         MsLoVbdfIqKIgYC0TFUSrbG0eX0D1z0TAbCPmpEQzVPinnM3x5P5DsZ1BdfSJlcFq9Z9
         0ScSY7BmAhi1pOsdB0XcKeeKHUzRH9NeMKUL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690477918; x=1691082718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1q7JLoG0EiFt7LGAh9L3HylZSzybbb6OAkvvFe4ftDc=;
        b=MxJbbj8ymF6pFyEWgFqPLq7IlQoAmxZ03jguRjG1TveoSAvNk0aqQzBlvVajNBZaCu
         z3jmpgXqMFs/cIXMLNaeECSRl9UbnvAyxwzAaFihRduxJj3RiNDf6sVzVUMGMTTymIiN
         8KjIonkMd5Paijk29qKG2NvXlJOC3igVhogfJzNB2qYVm5IbtVTQtbqSdQmlVg5jz54D
         Fb/ZpkM/zc6256ddOg3MsMea1MpmxD33r2IO22wij12A7P/MVUjBciL5j9nnAGI9EYHJ
         Uzp4prYi1IaOIkKP67fHNLwhYap0xO+SAua4vH9eCJ3aBUVOnWH4KLYrZx6dh3v3twt+
         Uzww==
X-Gm-Message-State: ABy/qLas/uqSuSHIwskcKojybs9DguXnszAyHg6nxT/61fouJKXjEEUn
        KDIOE0YyRP+IKSGsHw7ISYetEQ==
X-Google-Smtp-Source: APBJJlFBgiXtVo8AUJIwI0lHDgU9pZVegnohFXgxcR27RD8DBWQ4NYAlY3Hvx+gAKcJhKhMvcN5zWA==
X-Received: by 2002:a05:6a00:1a8a:b0:686:bc23:e20a with SMTP id e10-20020a056a001a8a00b00686bc23e20amr5939624pfv.21.1690477918218;
        Thu, 27 Jul 2023 10:11:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y2-20020aa78542000000b0066a31111ccdsm1727706pfn.65.2023.07.27.10.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:11:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] media: venus: Use struct_size_t() helper in pkt_session_unset_buffers()
Date:   Thu, 27 Jul 2023 10:11:30 -0700
Message-Id: <169047788705.2909569.12794509978389985930.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZKBfoqSl61jfpO2r@work>
References: <ZKBfoqSl61jfpO2r@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Jul 2023 11:17:22 -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size_t() over struct_size() when no pointer instance
> of the structure type is present.

Applied to for-linus/hardening, thanks!

[1/1] media: venus: Use struct_size_t() helper in pkt_session_unset_buffers()
      https://git.kernel.org/kees/c/cdddb626dc05

Take care,

-- 
Kees Cook

