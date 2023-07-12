Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C7F750EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjGLQoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGLQoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC1E136;
        Wed, 12 Jul 2023 09:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D95B961828;
        Wed, 12 Jul 2023 16:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB35AC433C8;
        Wed, 12 Jul 2023 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689180245;
        bh=YEyyeDnxoiSpMFUKd5oNis2MAXGoo/XvAQnqVJuUlDE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uHg6uj6zsJlQUP4cWQQQs4yFGNPZUUSmDjeoBLVnfHhXBnT+lNcme+Ap1QWwolTFg
         14tlsvwLBP0mKWMAo38v30sbufZihfkFseLEMjHkcYqAUNEutSoY5xWMKVbgmr451+
         O5Q7APdUmvQIwBiVjPnfjcUbZR0zB5eBvFk5NlBdZO+AT9gWzJD7vkjhi/4s+yNtle
         rmBoksdTG34Warlcn3ANcwkyspyf2himKZU2pTcnr62PSED/yyRMYMzPbAhfePFkXQ
         kcAu5pFt5hiQennsH80m4hp6w1X2Ix7BC7ES6rETaJJq9Kg+3mgWU4t2qcZUBvuAOE
         SM6bQR8cFvqmQ==
Message-ID: <c7ed2eb2-3b0a-a75e-bca9-641f802d6e15@kernel.org>
Date:   Wed, 12 Jul 2023 18:43:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1 0/3] Add notifier call chain to Embedded USB Debug(EUD)
 driver
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1689148711.git.quic_schowdhu@quicinc.com>
From:   Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <cover.1689148711.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.07.2023 10:22, Souradeep Chowdhury wrote:
> This patch series adds the notifier chain to the Embedded USB Debug(EUD) driver.
> The notifier chain is used to check the role switch status of EUD. Since EUD can
> function only in device mode, other modules trying to do role-switch on the same
> port have to first check the EUD status by calling this notifier chain and based
> on the status proceed or block their role-switching step. The modules can call
> the notifier through the call eud_notifier_call_chain and pass their own
> role switch state as the argument. This chain will also be able to handle the
> scenario of multiple modules switching roles on the same port since this can
> create a priority and ordering among them for conflict resolution.
> 
> Souradeep Chowdhury (3):
>   usb: misc: Add the interface for notifier call for Embedded USB
>     Debugger(EUD)
>   usb: misc: Add notifier call chain to Embedded USB Debug(EUD) driver
>   MAINTAINERS: Add the header file entry for Embedded USB debugger(EUD)
Please actually CC all maintainers, as present in the MAINTAINERS file..

Consider using b4:

https://b4.docs.kernel.org/en/latest/index.html

Konrad
> 
>  MAINTAINERS                          |  1 +
>  drivers/usb/misc/qcom_eud.c          | 52 ++++++++++++++++++++++++++--
>  drivers/usb/misc/qcom_eud_notifier.h | 10 ++++++
>  3 files changed, 61 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/usb/misc/qcom_eud_notifier.h
> 
> --
> 2.17.1
> 
