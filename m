Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D6D7FDBC9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbjK2Ppb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjK2Pp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:45:28 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9138D4A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:45:34 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cdde2aeb64so291953b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1701272734; x=1701877534; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NwHFWowqWyDEb2Wwo3i4LmdcNM+GbWwDzbQkVnnqols=;
        b=OKdKmHAmvjl9q/t2sP/tDCb3CXHVAfY0esPUD2GjyHFmbjlShsPkvfYDOHheCW8+Be
         bxbDhVau2rP3cEEr2xSb4NJnh1qY+1JlIxA4txKsbgP2G8/0vawfDuX4PpVzXEtGs8t7
         oYQA49UiEshldn7wyFivEaXg+NfTZU6RNbJdHBgAXlDSAVXvbgccvaa8CpfTtLhnSIq1
         blJOt/iB4hU39UjXjIWpFEVcJ/wq99ZbdSUFx5NueOSRp/wi9DTifHWh/NDJis6C+nnR
         qFPhbayRz0e6X3YU3kBTOvIMbL1diz+QhohTm8glLjONwGE58xayvUFbAtlBaT2qcNSm
         eNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701272734; x=1701877534;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwHFWowqWyDEb2Wwo3i4LmdcNM+GbWwDzbQkVnnqols=;
        b=vFDCHF/clT/D3LpNL0AYitFAxRLCN1w0svOHHUVxDiwda4KapuWgBPcfOjzuYQrtH0
         eJq8FAqty4WJzwaWGzKWPVzfEZk2Vu8YzArnkVTKH7oi12r4AKvA6NEYFKepLvE06LCC
         44wXmyCpKZhc+1eIVFOaKBoqRQaGtd2Qmjf7QusHPBoVK9eWwoRuFtt8ovCbmyld4iv9
         0hkLyNIL/zjk1Jsy2N5qLQoLP3ExWB8nhOAgbCM8orO+T4Lqc0hGRRuu2GJPGA3JxFXP
         GygDE/cdWg85kBGx2X0RhfhFM1hoiiw3gzE1rk8WH7owVqH0Q4h4b9AT/xYNDFFd3dbZ
         WP+w==
X-Gm-Message-State: AOJu0YyQ7S5PkAI6B0SSnmAoiMOxkm3X+GQoQlCenEPr7dr+tqFlPMG4
        r/NU1l+pbnbgEycsrv72+xRfgQ==
X-Google-Smtp-Source: AGHT+IGclN/oppycOMAUcuhAMoVqfAFTVeiSpxJjAg11vAVb0DKwhzWdIt65fU8WkFdg/gegVjNOlg==
X-Received: by 2002:a05:6a21:328a:b0:187:a75d:29dd with SMTP id yt10-20020a056a21328a00b00187a75d29ddmr25066343pzb.40.1701272734232;
        Wed, 29 Nov 2023 07:45:34 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id y28-20020aa79e1c000000b006cddecbf432sm474637pfq.96.2023.11.29.07.45.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Nov 2023 07:45:33 -0800 (PST)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Jiang Yihe'" <jiangyihe042@gmail.com>
Cc:     "'Jacob Pan'" <jacob.jun.pan@linux.intel.com>,
        "'Len Brown'" <lenb@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Zhang, Rui'" <rui.zhang@intel.com>,
        "'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
        "Doug Smythies" <dsmythies@telus.net>
References: <20231129143132.32155-1-jiangyihe042@gmail.com> <CAJZ5v0jfEsNVu=fg+Xa118F=hCGGB33U5SbiqWeCMaVMqNpUEA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jfEsNVu=fg+Xa118F=hCGGB33U5SbiqWeCMaVMqNpUEA@mail.gmail.com>
Subject: RE: [PATCH] intel_idle: add Cometlake support
Date:   Wed, 29 Nov 2023 07:45:34 -0800
Message-ID: <001701da22db$180872c0$48195840$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGdZaOMTCAu85nrZizeQdO70JhFLwDSqyoEsQRR5tA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This proposed patch has been submitted at least once before.
(I think more than once, but only found 1)
Reference:
https://lore.kernel.org/linux-pm/20200227013411.1.Ica3bb9fa898499d94e0b0a=
2bfa08ec46c89d84fa@changeid/

I have a Cometlake processor and am not in favor of this patch.
Reference at to why not:
https://bugzilla.kernel.org/show_bug.cgi?id=3D210741

... Doug

On 2023.11.29 07:19 Rafael wrote:
> +Rui and Artem
>On Wed, Nov 29, 2023 at 3:32=E2=80=AFPM Jiang Yihe =
<jiangyihe042@gmail.com> wrote:
>>
>> Since the Cometlake C-State is supported, support for Cometlake =
should
>> be added to intel_idle. Just use Kabylake C-State table for Cometlake
>> because they share the same table in intel_cstate.
>>
>> Signed-off-by: Jiang Yihe <jiangyihe042@gmail.com>
>> ---
>>  drivers/idle/intel_idle.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> index dcda0afec..f83f78037 100644
>> --- a/drivers/idle/intel_idle.c
>> +++ b/drivers/idle/intel_idle.c
>> @@ -1418,6 +1418,8 @@ static const struct x86_cpu_id intel_idle_ids[] =
__initconst =3D {
>>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,             =
&idle_cpu_skl),
>>         X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,          =
&idle_cpu_skl),
>>         X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,            =
&idle_cpu_skl),
>> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,         =
&idle_cpu_skl),
>> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,           =
&idle_cpu_skl),
>>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,           =
&idle_cpu_skx),
>>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           =
&idle_cpu_icx),
>>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,           =
&idle_cpu_icx),
>> --


