Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE253771C88
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjHGIqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHGIqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:46:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BEC92;
        Mon,  7 Aug 2023 01:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 971FE615F5;
        Mon,  7 Aug 2023 08:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B26C433C8;
        Mon,  7 Aug 2023 08:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691397976;
        bh=gmL0M/6OzGAUmTz+EM8z1UlkEbfkUv74TK4ii5tZs3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oknCvoCaUlRhmw5A62sGWLQYBTg2Roykrqyu4tsNE3feFsJxcwOVQ2Hqeq9c7T+yG
         9RX+BFScmMDCZ2Q3b2JWWHPwVCXPEPPTaToEFHSs4ecgmQ61Xuj4RQsXT5eIf/PWHp
         2Zaanl5dedFp/fV/LqAfHmXHMgjTakcasAJE5e623iLRscqOTmAW8bEspwm8DTv1n4
         XG0FX8Pi5cu8go3ti8fGRb0TDRzm0vo+vsn7jLFS/bfH+8gYiWNKEJNZiNpvdQC6e7
         WpIAfgbM3JS5LEp4BZx16pEIZuJDMK+pQ0YIrCGBNnjFF5oXfZgqDSjAgyf4LDh8dk
         uyNVp4i9NDtOQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qSvsU-0007Ti-1K;
        Mon, 07 Aug 2023 10:46:15 +0200
Date:   Mon, 7 Aug 2023 10:46:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] firmware: qcom_scm: Add support for Qualcomm
 Secure Execution Environment SCM interface
Message-ID: <ZNCvVrDdgiEUsIgc@hovoldconsulting.com>
References: <20230730161906.606163-1-luzmaximilian@gmail.com>
 <20230730161906.606163-3-luzmaximilian@gmail.com>
 <ZM0r-ZrkWXBtNZJZ@hovoldconsulting.com>
 <b4d7dbca-f77f-dd8b-2b4c-c82bee086627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d7dbca-f77f-dd8b-2b4c-c82bee086627@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 10:11:18PM +0200, Maximilian Luz wrote:
> On 8/4/23 18:48, Johan Hovold wrote:
> > On Sun, Jul 30, 2023 at 06:19:03PM +0200, Maximilian Luz wrote:

> >> +MODULE_ALIAS("platform:qcom_qseecom");
> > 
> > No need for MODULE_ALIAS() either.
> 
> Oh right. As long as the module and device name match this should work
> automatically, correct? I forgot about that.

Yeah, the module alias is only used when determining which modules to
load.

The driver and platform device will still be matched and bound based on
their names.

Johan
