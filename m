Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866B47F1849
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjKTQQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjKTQQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:16:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AB3F5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:16:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33359C433CD;
        Mon, 20 Nov 2023 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700496979;
        bh=RqLtxq3JS2WZJO5Z7BQnNMc6WxYyQfEIqiv4EGNlGr0=;
        h=From:To:Cc:Subject:Date:From;
        b=PQgenOGjN8Ejyic2TC8oSdPje9uSLE+ChZmT2IojOrV2JVwM4LY1pDg295rZaApGa
         SzQ8Sefrjlq8VNBv7cqNkR9BKfMkIEEuk8ij6oA/TCUv6Ol1EqZmmS9CfgyOkXqUBr
         ZXEEwuglqN7jLhqZwIKJO5YZWaKMTjiDe51JVoJR42gpqCGRG2OSMACDkVMBYU6RzU
         S14zyWE7s6d5v9MSwHIZuoWSuxa19ZcD4ABx07HqqnlRErdk9ZtwMrnORFyI1JGhQ9
         +lcO22aHCMjuOY27UG6Ek2JZZcse6tweWwcN/pWf+HAedtU3tN19QTeJ+wo/pcx8V/
         as+OyRmrB3XJQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r56wm-0001vk-1I;
        Mon, 20 Nov 2023 17:16:28 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] USB: dwc3: qcom: fix wakeup after probe deferral
Date:   Mon, 20 Nov 2023 17:16:04 +0100
Message-ID: <20231120161607.7405-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing a recent series that addresses resource leaks on probe
deferral [1] I realised that probe deferral can break wakeup from
suspend due to how the wakeup interrupts are currently requested.

I'll send a separate series for the Qualcomm devicetrees that used
incorrect trigger types for the wakeup interrupts. Included here is just
a patch fixing the binding example which hopefully will make it less
likely that more of these gets introduced. Fortunately, there should be
no dependency between this series and the devicetree one.

Note also that I decided to include a related trivial cleanup patch.

Johan


[1] https://lore.kernel.org/lkml/20231117173650.21161-1-johan+linaro@kernel.org/


Johan Hovold (3):
  dt-bindings: usb: qcom,dwc3: fix example wakeup interrupt types
  USB: dwc3: qcom: fix wakeup after probe deferral
  USB: dwc3: qcom: simplify wakeup interrupt setup

 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml |  4 ++--
 drivers/usb/dwc3/dwc3-qcom.c                         | 12 ++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

-- 
2.41.0

