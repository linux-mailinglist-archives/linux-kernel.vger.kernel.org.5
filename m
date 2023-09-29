Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C95E7B35A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjI2Oer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjI2Oed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:34:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692E81BE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:33:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c6193d6bb4so191955ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695998009; x=1696602809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crbf+k0hTPm5Cd8YaXbLKN5kqKGElW+L9hMz0P1lr6A=;
        b=KqDaxZZQkYtX2yDE227tD0OJUJlVmIvXuzRmRzMSs8BHtHpQMWDm1gfyPeVDNjU4CO
         /2RUSFi6dKBvzht3tY96U4PcU45uDvROvpmh77XE7MIn/JTOZm0h5L2l3gfG3w3+EmRV
         /nQlido4whxVo4GT0Cr6bnwaaBSF9a6bYFkf17StisOD0ZtMC36Sqm+8hICCPytL6Csq
         DIMfjOTerOvYjGjvm8isca2JJh+1Z9F7AoGz1gSlNKDwvlVHZWScsGMnfOoBr65YSYVw
         sUJ1dHRt4rZtKoC+JY3l05ZeHtLOEzB7toYx/aRE2Y3GwOtGPCyaHrRd4m+se28fXvA/
         xUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695998009; x=1696602809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Crbf+k0hTPm5Cd8YaXbLKN5kqKGElW+L9hMz0P1lr6A=;
        b=JhoMup+Fm/t8Xzg19Z8FHdBxS5t/t8VesZqX/B22e2Idc6A8CHk5/jhTYIhd7CxV2o
         FZ6j2fuKxpxejryTcaDzGpfdjHeZt6mdQkdxXayNxxzIL5OnI5JML85lxHkKkeAHQXd9
         Vv0uJOFkXLV5z6XoPfKIYY1gp8BC+03tPk7xsSpCuWTiXbtS0YFheUm4mJ1jI5m0ffga
         CMw4STyRFjt8T8B85R1zJa7nmJ85BFQAjoPaep35rHyV7VmuA7pa0Zi0WryMOfggvxxL
         FrY6yw8Zw9CWPBAo9cwY6/cAkG9ftdzblS02BnDy64A0W2SfcgHb7OSEtkQwYOKQMgsW
         SNvw==
X-Gm-Message-State: AOJu0YzJkygVqi75guK45i+qpHthgdqOzKwhqD4IL1VljWVBMEyxQyrS
        HAxHM0FFKFTjTU6gBHUNXDnGIPDUXzqwSrp49aqa2g==
X-Google-Smtp-Source: AGHT+IHK5XOUV9ZvRPOnrg1t3Tlxv5te4wCe9nvTwkQL4QGkdcFxDRQPTSRNERmG16ySaVP7JCn5kyb/vqlQyfZEcEw=
X-Received: by 2002:a17:902:da91:b0:1c3:5df4:a778 with SMTP id
 j17-20020a170902da9100b001c35df4a778mr923257plx.13.1695998008616; Fri, 29 Sep
 2023 07:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230829234426.64421-1-tony.luck@intel.com> <20230928191350.205703-1-tony.luck@intel.com>
In-Reply-To: <20230928191350.205703-1-tony.luck@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 29 Sep 2023 16:33:17 +0200
Message-ID: <CALPaoCjxW70h=rTNNiShEc8bmgwEaHpFnAHRB-m=ch47WdQsig@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Add support for Sub-NUMA cluster (SNC) systems
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Thu, Sep 28, 2023 at 9:14=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
>
> The Sub-NUMA cluster feature on some Intel processors partitions
> the CPUs that share an L3 cache into two or more sets. This plays
> havoc with the Resource Director Technology (RDT) monitoring features.
> Prior to this patch Intel has advised that SNC and RDT are incompatible.
>
> Some of these CPU support an MSR that can partition the RMID
> counters in the same way. This allows for monitoring features
> to be used (with the caveat that memory accesses between different
> SNC NUMA nodes may still not be counted accuratlely.

Is an "SNC NUMA node" a "sub-NUMA node", or a NUMA node on which SNC
has been enabled?

Thanks!
-Peter
