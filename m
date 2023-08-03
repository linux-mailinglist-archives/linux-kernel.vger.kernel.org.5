Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E091076ED5F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbjHCO6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjHCO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA278173F;
        Thu,  3 Aug 2023 07:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4F861DEB;
        Thu,  3 Aug 2023 14:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD23C433C8;
        Thu,  3 Aug 2023 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691074714;
        bh=yMg1YEwuJlIFczOQZY8fQXTUaLaqCwPe1K5AJfailb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnZo4TfWlyzyTmeTVwJWce2tqZsbJPYrVVSOM8snyxCcEa18Q473++Mm5TzoZbXF4
         XG/fbkrFrX8fv2hmeJHqpy34ohk+n3uYw4VyKDaeQBvKAblqmLjRXZOr+s5scO1P3S
         ISgoZraioxE44UFUuwofEcSSikNuLQl4qrcUE5ALRpzMgRVvoYVKXBBKu0QWubvLXt
         +nivNO666XHDvB7isEqr2AOhNL3doay5dUfd9BsKgbeuSd3Yr2LPd49UxnVCd5HG4b
         ingQ56KYEVvDxjWb8/cBWUsziSCYyn3eCzRX5ThpJinsY6AVmqyIzTpdAkt/Z5JQKA
         dqb99rMqyWC/A==
Date:   Thu, 3 Aug 2023 16:58:28 +0200
From:   Simon Horman <horms@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] bluetooth: qca: use switch case for soc type
 behavior
Message-ID: <ZMvAlO2Y9CfJtOlE@kernel.org>
References: <20230803-topic-sm8550-upstream-bt-v3-0-6874a1507288@linaro.org>
 <20230803-topic-sm8550-upstream-bt-v3-2-6874a1507288@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803-topic-sm8550-upstream-bt-v3-2-6874a1507288@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:45:27AM +0200, Neil Armstrong wrote:
> Use switch/case to handle soc type specific behaviour,
> the permit dropping the qca_is_xxx() inline functions
> and maked the code clearer and easier to update for new

nit: maked -> make

> SoCs.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

...
