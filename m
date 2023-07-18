Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6657580E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjGRP3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjGRP3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:29:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286081B1;
        Tue, 18 Jul 2023 08:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BCB061627;
        Tue, 18 Jul 2023 15:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13629C433C8;
        Tue, 18 Jul 2023 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689694175;
        bh=gfIcQMcEA2JMSiCekxbZMv18Ww2UR5Kx8avTWh0Rq2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agarwvePgX89eG1fPnzVQKKXMgOrXQlVihkvwG9RtJw22fk29qZbvyn/X6KsDIW6J
         Gq/iCReTYU4Lu/zDSjRndrabBq37UdFqUnEK8rtqQTknlGVMjplCwNJZKrcmLoioXA
         ERWprgYUbLRwDhEvdrmxxIY4JBbS7bmo97iSbn+nebTW60+n3DDwYOXEHoGAadJmBt
         +sc0oBhKkYB5thOHNxYVOuYM1JwxrWBlTFgQ5F/quhSEGsvDZ7WMZlGrkdU2R1SD/Y
         FCzpvPWoq3T6Uq5f6nia2ihWrfhilLqxWilDIWyktSMKK5Zgfr6U6iiYos2CV7Cgh0
         zRVooIRDw1wOg==
Date:   Tue, 18 Jul 2023 08:32:59 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Ninad Naik <quic_ninanaik@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ppareek@quicinc.com,
        psodagud@quicinc.com, quic_kprasan@quicinc.com,
        quic_ymg@quicinc.com, Andrew Halaney <ahalaney@redhat.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v2] pinctrl: qcom: Add intr_target_width field to support
 increased number of interrupt targets
Message-ID: <fskuol2q4wbfilrz3x3dcmikhjgfsajgnuqjnp4petxr2ne6at@zfnonisxnjh3>
References: <20230718064246.12429-1-quic_ninanaik@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718064246.12429-1-quic_ninanaik@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 12:12:46PM +0530, Ninad Naik wrote:
> SA8775 and newer target have added support for an increased number of
> interrupt targets. To implement this change, the intr_target field, which
> is used to configure the interrupt target in the interrupt configuration
> register is increased from 3 bits to 4 bits.
> 
> In accordance to these updates, a new intr_target_width member is
> introduced in msm_pingroup structure. This member stores the value of
> width of intr_target field in the interrupt configuration register. This
> value is used to dynamically calculate and generate mask for setting the
> intr_target field. By default, this mask is set to 3 bit wide, to ensure
> backward compatibility with the older targets.
> 
> Changes in v2 :
> -----------------
> - Changed initial definition of intr_target_mask variable to use GENMASK().
> - Update commit subject appropiately.
> - Add Fixes tag.
> - v1 : https://lore.kernel.org/all/20230714061010.15817-1-quic_ninanaik@quicinc.com/

Thanks for adding a good changelog, very much appreciated. The changelog
should be added below the '---' line though, as it typically don't add
value to the git history (except drivers/gpu/* which wants it here...).

Perhaps Linus can drop it as he applies the patch, no need to resubmit
unless he ask you to.

Thanks,
Bjorn
