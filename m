Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379C0797D71
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 22:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbjIGUf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 16:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjIGUfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:35:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48301703;
        Thu,  7 Sep 2023 13:35:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83690C433C9;
        Thu,  7 Sep 2023 20:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694118951;
        bh=TbTNqEZtaQtEwYXEkP4OSzwJn8Qf383uiVg4TmHkAao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OOZtBJGUMk6O+26CLZfB3MhkmJCBPbGPCPke/YmTotfNHa0IGJqL16j6XMe3j3DFN
         /HRawg5Y8OoryXM9XrNyE4S0Jqgykhh7dC5zHzNALZjZF/xxPTe7S90oQkrpKYYOI5
         Sh2K7WCLNF9CK0XVqbZDFD8qdJTGLpmUEQtCNlZxsBMy+jxyGaey7J7ExvOXE1h6Jv
         UMjjEXgXZcwaJuiZiQgvSGU7EfkR+PdTDVFK2FhGWZdaZNGIicGNsqMMVhbBiJClnf
         9NjauY+dyJLf42wqL4tU8J8701E6N2L8RfynU7ji6tgFI2nr5bRWTy/Y5KsJuynqjk
         8aBBweiWjCK5Q==
Date:   Thu, 7 Sep 2023 13:40:03 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v6 3/3] firmware: Add support for Qualcomm UEFI Secure
 Application
Message-ID: <s6yadwe6zgcim5dhjfo2zwlrd2ac3favmcf7c4y46kmub5pdtm@qwesv7eaajil>
References: <20230827211408.689076-1-luzmaximilian@gmail.com>
 <20230827211408.689076-4-luzmaximilian@gmail.com>
 <0d7697fd-11b3-1d4a-78da-7e5eb293d186@quicinc.com>
 <072b3df6-09fb-98a8-2b58-41dfcabd98c0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <072b3df6-09fb-98a8-2b58-41dfcabd98c0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 11:53:08PM +0200, Maximilian Luz wrote:
> On 8/27/23 23:26, Trilok Soni wrote:
> > On 8/27/2023 2:14 PM, Maximilian Luz wrote:
> > > +config QCOM_QSEECOM_UEFISECAPP
> > > +	bool "Qualcomm SEE UEFI Secure App client driver"
> > 
> > Why not "tristate"? This driver can be a loadable module, right?
> 
> As I understand, modular efivars have still not been fully sorted out in
> the kernel. For example, userspace could try and mount efivarfs before
> the module has been loaded and by that erroneously determine that the
> system doesn't support efivars. So requiring it to be built in for now
> is more of a workaround (which has been suggested by Johan Hovold).
> 
> There is no technical limitation in this part of the code itself, so
> enabling it (and QCOM_QSEECOM for that matter) to be built as module
> should be fairly straightforward once that's been sorted out.
> 

Afaict without resolving the efivars issue this is boolean in practice
anyways. As such, I intend to pick this for v6.7, and we can transition
to modular support incrementally from here.

Many thanks for sticking to the effort, Maximilian.

Regards,
Bjorn
