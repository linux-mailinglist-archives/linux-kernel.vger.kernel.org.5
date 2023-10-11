Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F386F7C5456
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjJKMwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjJKMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:52:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28137A4;
        Wed, 11 Oct 2023 05:52:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADCAC433C7;
        Wed, 11 Oct 2023 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697028767;
        bh=7nNHhTFSnvsctexULERMu++eP5boExVclBtDAh2DWK8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=byiSFe85ODvmEz8k8cS0xJ3/08MXWJB2WtfGGMACCLtPca+YyLQ1GAhI6j1huUlgS
         qSXhG7H7mgi+XQ+w9Kj4wNTexSEsVDczEkr5XH5PN3gvbMYRJn4Okbj9lSVWGriM0F
         8CRNOtHbWd4DZ7HjYZUNmo37wMRSZnlIeldFwsksj9nVxKp/ae5E+to7Y02A206M5i
         YwBAavrgIqIxw7KgDFVHJ0jE7Xk2uQkBEN2r86OToVJq5JsiUDpv8YRGALYAa4gv4f
         PGJehCdMzCclMdLyYRRvxB0Fv3i4X5npEXjowsy19UyVltjoHm60R2DAKA5+mEvyTM
         GBoPKfEzPEKVg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5068dab8c00so5746503e87.0;
        Wed, 11 Oct 2023 05:52:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyy/cOf6oGXwA2UrUnIHUIQafmwO2KlpeP4MeT1gpaJ66xTNcLg
        ZF7sMPvvhwRtAzsGCImeg7zm1Lh3Y8Dda3IZiA==
X-Google-Smtp-Source: AGHT+IH/9CIDym2+ooxw52sokSgt93JvGLmPMXG8mQ+BYLgc6mr8q1Zja1fo33uvxZMXbJuLjTuECww1Pj/VshNPtQk=
X-Received: by 2002:a19:6456:0:b0:503:442:5957 with SMTP id
 b22-20020a196456000000b0050304425957mr16044041lfj.41.1697028765631; Wed, 11
 Oct 2023 05:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231011112726.166052-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20231011112726.166052-1-dmitry.baryshkov@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 11 Oct 2023 07:52:32 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+HdceLczej4_q-wjg2870v3y-e_E+jEq0xbetDguaXAw@mail.gmail.com>
Message-ID: <CAL_Jsq+HdceLczej4_q-wjg2870v3y-e_E+jEq0xbetDguaXAw@mail.gmail.com>
Subject: Re: [PATCH] of: export of_find_next_cache_node() for modules
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 6:27=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> The qcom-cpufreq-nvmem module uses of_find_next_cache_node() function,
> so export it to be available to the modules.

You really should be using the cacheinfo API which has already parsed
the cache nodes.

Also, why do you need a platform_device? I don't see a driver.
cacheinfo already creates a struct device, so kind of weird to have 2
devices.

Rob
