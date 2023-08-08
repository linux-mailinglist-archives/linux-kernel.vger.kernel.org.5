Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98546774C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjHHVH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjHHVHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5FC1715
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691528797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yk2jMcUKin7KHZxfkihPedUxC+ohlFBFrxtCM2fiaX8=;
        b=CRpgi2YM6ScAlWcve4pi1QqvaN7YN5HPgx6ZqHBrpFbHGKRsN0DRe8zIVydAfwjTG5jvgx
        rhEequFmMYU+hNrmvHNILu8SeUr2aq1gyganaXbCYzCfRSkN8/5v+p23kfOZjzGBs8928u
        2GdyT7C3LConkydEqMzSlUGikV3VYVY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-4IltOa7MOJaMmZDMS5oIpw-1; Tue, 08 Aug 2023 17:06:36 -0400
X-MC-Unique: 4IltOa7MOJaMmZDMS5oIpw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63cd1ea05d7so3011336d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691528795; x=1692133595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yk2jMcUKin7KHZxfkihPedUxC+ohlFBFrxtCM2fiaX8=;
        b=hVii5PDaRVxhexfoQ+Fq+Lif+jWMiom8gF+dLVRkB0wQMFJs7Q5OknBWmsAfc+amlY
         hNb8W4XJ+3hRhCBlGHcLkTmwLiU43boU04EAISPqJidNfi25nHFzBMl132fDAJ8KXMvr
         Zq4IpWRdJlOY4XvhPN3p690curzCrTR5DVZC5adjWvW09MgcWXAvW4Rk7UZUZ1MPvPaM
         qeK6fBQMM6PBVpKSEvVJNUK3+nFRR7Brf8kHSmmTFbWGM1dNJxuN/UdXU/5UoEsNWLXs
         aDpjelrucUxuq90CUbt++skOfTQqb30bNOeZf1gurJ24mBY/Ox8BqoNemBWWQGqoeT39
         zApw==
X-Gm-Message-State: AOJu0Yzr/M7dtacza8RNYj011PE6BaDBP5O0SNF1WNF2MXO/s8TyVabe
        z6bJzTob1OUlAopYjwGQ3OtA9YK2aVVJp5P6ncDKDgdzc7Qhy5Io4QCssBCT6TkcnzZIxHwzhzj
        dPEyD8JrAJxxDFoDs+ofA0lTp
X-Received: by 2002:a05:6214:4114:b0:63d:3b2:482f with SMTP id kc20-20020a056214411400b0063d03b2482fmr12798285qvb.5.1691528795432;
        Tue, 08 Aug 2023 14:06:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsnwPimCXVkyjta9FS/2+45j9WVrBZygFxns7FwKn06ZeNICuX0tldF9IOYDjKZKH2ghDHZg==
X-Received: by 2002:a05:6214:4114:b0:63d:3b2:482f with SMTP id kc20-20020a056214411400b0063d03b2482fmr12798262qvb.5.1691528795172;
        Tue, 08 Aug 2023 14:06:35 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id p9-20020a0ce189000000b0063f822dae2csm2597025qvl.54.2023.08.08.14.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:06:34 -0700 (PDT)
Date:   Tue, 8 Aug 2023 16:06:32 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Ninad Naik <quic_ninanaik@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppareek@quicinc.com, psodagud@quicinc.com,
        quic_kprasan@quicinc.com, quic_ymg@quicinc.com,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v2] pinctrl: qcom: Add intr_target_width field to support
 increased number of interrupt targets
Message-ID: <pdag3mk5fru4x7zc3lljrt3mlg2g2pa6l6h7l6fyd6n2kjydli@yvxpnjelwfns>
References: <20230718064246.12429-1-quic_ninanaik@quicinc.com>
 <fskuol2q4wbfilrz3x3dcmikhjgfsajgnuqjnp4petxr2ne6at@zfnonisxnjh3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fskuol2q4wbfilrz3x3dcmikhjgfsajgnuqjnp4petxr2ne6at@zfnonisxnjh3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 08:32:59AM -0700, Bjorn Andersson wrote:
> On Tue, Jul 18, 2023 at 12:12:46PM +0530, Ninad Naik wrote:
> > SA8775 and newer target have added support for an increased number of
> > interrupt targets. To implement this change, the intr_target field, which
> > is used to configure the interrupt target in the interrupt configuration
> > register is increased from 3 bits to 4 bits.
> >
> > In accordance to these updates, a new intr_target_width member is
> > introduced in msm_pingroup structure. This member stores the value of
> > width of intr_target field in the interrupt configuration register. This
> > value is used to dynamically calculate and generate mask for setting the
> > intr_target field. By default, this mask is set to 3 bit wide, to ensure
> > backward compatibility with the older targets.
> >
> > Changes in v2 :
> > -----------------
> > - Changed initial definition of intr_target_mask variable to use GENMASK().
> > - Update commit subject appropiately.
> > - Add Fixes tag.
> > - v1 : https://lore.kernel.org/all/20230714061010.15817-1-quic_ninanaik@quicinc.com/
>
> Thanks for adding a good changelog, very much appreciated. The changelog
> should be added below the '---' line though, as it typically don't add
> value to the git history (except drivers/gpu/* which wants it here...).
>
> Perhaps Linus can drop it as he applies the patch, no need to resubmit
> unless he ask you to.
>
> Thanks,
> Bjorn
>

Gentle ping on this one... but then I realized that linusw isn't CC'ed
on this patch directly, and I'm unsure of what the workflow is for
pinctrl. ./scripts/get_maintainer.pl shows he should have been in the CC
list ideally :)

Maybe send a v3 with the changelog dropped from the actual message (i.e.
follow Bjorn's advice), and make sure to include the folks
get_maintainer tells you to so this gets picked up (or maybe just saying
Linus' name will make him appear out of the woodworks if we're lucky):

    ahalaney@fedora ~/git/linux-next (git)-[7de73ad15b73] % b4 am 20230718064246.12429-1-quic_ninanaik@quicinc.com
    Grabbing thread from lore.kernel.org/all/20230718064246.12429-1-quic_ninanaik@quicinc.com/t.mbox.gz
    Analyzing 3 messages in the thread
    Checking attestation on all messages, may take a moment...
    ---
      ✓ [PATCH v2] pinctrl: qcom: Add intr_target_width field to support increased number of interrupt targets
      ---
      ✓ Signed: DKIM/quicinc.com
    ---
    Total patches: 1
    ---
     Link: https://lore.kernel.org/r/20230718064246.12429-1-quic_ninanaik@quicinc.com
     Base: applies clean to current tree
           git checkout -b v2_20230718_quic_ninanaik_quicinc_com HEAD
           git am ./v2_20230718_quic_ninanaik_pinctrl_qcom_add_intr_target_width_field_to_support_increased_number_of_in.mbx
    ahalaney@fedora ~/git/linux-next (git)-[7de73ad15b73] % ./scripts/get_maintainer.pl ./v2_20230718_quic_ninanaik_pinctrl_qcom_add_intr_target_width_field_to_support_increased_number_of_in.mbx
    Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
    Bjorn Andersson <andersson@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
    Konrad Dybcio <konrad.dybcio@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT,blamed_fixes:1/1=100%)
    Linus Walleij <linus.walleij@linaro.org> (maintainer:PIN CONTROL SUBSYSTEM,blamed_fixes:1/1=100%)
    Bartosz Golaszewski <bartosz.golaszewski@linaro.org> (blamed_fixes:1/1=100%)
    Yadu MG <quic_ymg@quicinc.com> (blamed_fixes:1/1=100%)
    Prasad Sodagudi <quic_psodagud@quicinc.com> (blamed_fixes:1/1=100%)
    linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
    linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM)
    linux-kernel@vger.kernel.org (open list)
    ahalaney@fedora ~/git/linux-next (git)-[7de73ad15b73] %

I'm eager to get this fix in so I can describe a missing IRQ or two
wrt ethernet GPIOs and submit that without stating the dependency
on this fix! :)

Thanks,
Andrew

