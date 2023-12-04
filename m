Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0AF803D45
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjLDSjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjLDSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:39:05 -0500
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E42FA;
        Mon,  4 Dec 2023 10:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
        t=1701715118; bh=rj7Er9R1xUABlk9cGEroopYihFMT61dNP76qORyH8LU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=43o/gGkgLpC4l6K12zlYt+pRDMhb+R1bIunqxnfaZiH+qBkGaiNt+gy3h8gB++v/g
         XI2BqFGANYQmFHLXs7hSf36vskRWxrq2TyLFifpfwbj8BfXupkynjhAsf1K64o57hm
         oY3nj9P4j8rHKsasN+LR1Ni6+QAaYGiMuVqPMpIw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: qcom: msm8226: Add CPU and SAW/ACC nodes
Date:   Mon, 04 Dec 2023 19:38:37 +0100
Message-ID: <12332815.O9o76ZdvQC@z3ntu.xyz>
In-Reply-To: <d1f1ee82-7997-4e36-a21a-7b70d2db9746@linaro.org>
References: <20231203-msm8226-cpu-v1-0-d18e83340b32@z3ntu.xyz>
 <20231203-msm8226-cpu-v1-2-d18e83340b32@z3ntu.xyz>
 <d1f1ee82-7997-4e36-a21a-7b70d2db9746@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 4. Dezember 2023 11:41:36 CET Konrad Dybcio wrote:
> On 3.12.2023 23:38, Luca Weiss wrote:
> > From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> > 
> > Add CPU and SAW/ACC nodes to enable SMP on MSM8226.
> > 
> > Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> > [luca: update some nodes to fix dtbs_check errors, reorder, cleanup]
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> 
> Looks like L2 SAW (@ 0xf9012000) is missing.. but then it's present
> on 8974.. but it's not bound by any driver :)

Right, I had this node before:

	saw_l2: power-controller@f9012000 {
		compatible = "qcom,saw2";
		reg = <0xf9012000 0x1000>;
		regulator;
	};

And then used like this:

	L2: l2-cache {
		compatible = "cache";
		cache-level = <2>;
		qcom,saw = <&saw_l2>;
	};

I decided to remove it because first there's no "qcom,saw2" (without a second 
compatible) in the yaml. And qcom,saw property in the l2-cache node also 
wasn't accepted. Since I'm not aware of any driver code currently using this 
(and the bindings not being particularly maintained, there's still this bit in 
.txt form?) I decided to remove it to not knowingly introduce binding errors.

Regards
Luca

> 
> The nodes you added here look correct FWIW
> 
> Konrad




