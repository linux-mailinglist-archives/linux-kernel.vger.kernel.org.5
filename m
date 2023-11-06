Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD4A7E2F50
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjKFV4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjKFV4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:56:03 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4440711F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:56:00 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so66249211fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699307758; x=1699912558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPhs6rysF6DasMcFlWcetB0SUQreo53hcaBGYIwCUKA=;
        b=cLZ5jCury2Y9BVn0WMUKIGjo5KIMFTTGM/ljuPB+UwGF0dM2UABad/uo1QcZ89jsIZ
         YYuY8RMefJ4jrGrfNM2CyRtRHMpZ0kAXz+G9DSlRyi4zMpi9c0zCBjd5SJcJt7XUA9fz
         w1gJ62bsO6NMdumLzn4LvINubhcTajhxpcl4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699307758; x=1699912558;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPhs6rysF6DasMcFlWcetB0SUQreo53hcaBGYIwCUKA=;
        b=cl/M9tvF13XQ6W4ZdYxasZiVxqV+lR6YPIn5xxmZrAfOzgybsjZDdHgTOhVoOu7O0j
         VivXDKO20XM9WwM7CVV+7RIi300/rLf9mIobu3aMyj7xzPQbd3+rDCxnleiWn0j+Gy37
         nrVsxt3R5tQOMqhopPIPAggmIjS0bgn14eXF/cdtPwoE8V9KRzEw3/t+RrpvrAs2LE++
         R4h6XR/7FbQd/urUTu13iu6p4I64ZY9QHJ2zuXsswV6Q877A7T9eJo6mAStrGYxI5Diz
         FJGyDzdjd+Au/mpP1bx6v6n+QCYuNL72N/fOQCjGThkYXTqA4rb7BIJWSqvZ0wkfmbsU
         YT2Q==
X-Gm-Message-State: AOJu0YxnOtmQM/cLNFqP6pzGLiupyRKl50imPVKrJnvVfvszv69Ohtxc
        3zqRKTUykvHm4R8v1N073FZ9guFtIycHlLZuVKqDOSOsum9WAcOc
X-Google-Smtp-Source: AGHT+IEwLGUljMTTnmDBOYDOS2P97CSh22lKY/YnB5/zNvxrhbW3lqGlDKYhx0sD7AWXifJZGCri2EKXnelUaxD2r7M=
X-Received: by 2002:a2e:b4a2:0:b0:2c5:52d:c9ff with SMTP id
 q2-20020a2eb4a2000000b002c5052dc9ffmr20722722ljm.10.1699307758491; Mon, 06
 Nov 2023 13:55:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Nov 2023 13:55:58 -0800
MIME-Version: 1.0
In-Reply-To: <5e83d947-c77f-9318-4a4c-377a8304b8fd@quicinc.com>
References: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
 <20231103193345.GY3553829@hu-bjorande-lv.qualcomm.com> <5e83d947-c77f-9318-4a4c-377a8304b8fd@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 6 Nov 2023 13:55:58 -0800
Message-ID: <CAE-0n50HwE+gNYotYXduer3b=O+c3ZWLC_8gEmpo0KQmtzmNvQ@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration
To:     Atul Dhudase <quic_adhudase@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        isaacm@codeaurora.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mukesh Ojha (2023-11-05 22:54:28)
>
>
> On 11/4/2023 1:03 AM, Bjorn Andersson wrote:
> > On Fri, Nov 03, 2023 at 04:27:12PM +0530, Atul Dhudase wrote:
> >> While programming dis_cap_alloc and retain_on_pc, set a bit
> >> corresponding to a specific SCID without disturbing the
> >> previously configured bits.
> >>
> >
> > As far as I can see, the only invocation of _qcom_llcc_cfg_program()
> > comes from qcom_llcc_cfg_program(), which is only called once, from
> > qcom_llcc_probe(), and here also seems to only be the single write to
> > these two registers.
>
> It does not look to be single write but the write is for each slice
> in the same register which was overriding other slices values.

Can you add that detail to the commit text? What's the seriousness of
the issue? Why should it be backported to stable? Is something seriously
broken because a slice configuration is overwritten? Does it mean that
some allocation made in a slice is being lost over power collapse (pc)
when it shouldn't be?
