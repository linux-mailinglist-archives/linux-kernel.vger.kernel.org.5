Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92A3770226
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjHDNrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjHDNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:47:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD429D1;
        Fri,  4 Aug 2023 06:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EFB462007;
        Fri,  4 Aug 2023 13:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EE9C433C7;
        Fri,  4 Aug 2023 13:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691156849;
        bh=Vus8oDWqbe6hI+z8JRRz2IwYSOmpWI93p8MNavKhkKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nlwKQVwKhVMc36MQa31XedPh72V5Kk3PA95jvM+710KkbpjU67UNPm9iLn1HkZtQM
         Uix8VnrHM7OZOtlKDUDtezNGWq6/QmacVNptoX1t2AG1W0aGWlUGyjC0UIsHlTuJ9i
         fkqdy9w1Ew/0BZrMQoSitYvblyORVT0kwHrz5opM=
Date:   Fri, 4 Aug 2023 15:47:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Trilok Soni <quic_tsoni@quicinc.com>
Cc:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V25 0/3] misc: Add driver support for Data Capture and
 Compare unit(DCC)
Message-ID: <2023080438-reacquire-obsessed-3e81@gregkh>
References: <cover.1687945879.git.quic_schowdhu@quicinc.com>
 <f25f8c43-2996-23ff-e6af-9e39b7fced86@quicinc.com>
 <774b688f-0324-9097-6504-58d15a3e6afb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <774b688f-0324-9097-6504-58d15a3e6afb@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 07:35:18AM -0700, Trilok Soni wrote:
> On 8/3/2023 12:06 AM, Souradeep Chowdhury wrote:
> > 
> > 
> > On 6/28/2023 3:53 PM, Souradeep Chowdhury wrote:
> 
> ...
> 
> > > 
> > > https://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/tools/-/tree/opensource-tools.lnx.1.0.r176-rel/dcc_parser
> > > 
> > > Changes in v25
> > > 
> > > * Updated the documentation of the structure dcc_config_entry as per
> > > the comments in V23
> > > * Updated the documentation of the dcc Kconfig definition as per
> > > comment in V24
> > > * Used u64 where applicable
> > > * Removed the mutex locks where it is not needed
> > > * Removed the use of unlikely keyword
> > > * Renamed "nr_link_list" to "max_link_list"
> > > 
> > > Souradeep Chowdhury (3):
> > >    dt-bindings: misc: qcom,dcc: Add the dtschema
> > >    misc: dcc: Add driver support for Data Capture and Compare unit(DCC)
> > >    MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver
> > >      support
> > > 
> > >   Documentation/ABI/testing/debugfs-driver-dcc  |   10 +-
> > >   .../devicetree/bindings/misc/qcom,dcc.yaml    |   44 +
> > >   MAINTAINERS                                   |    8 +
> > >   drivers/misc/Kconfig                          |    8 +
> > >   drivers/misc/Makefile                         |    1 +
> > >   drivers/misc/qcom-dcc.c                       | 1312 +++++++++++++++++
> > >   6 files changed, 1378 insertions(+), 5 deletions(-)
> > >   create mode 100644 Documentation/devicetree/bindings/misc/qcom,dcc.yaml
> > >   create mode 100644 drivers/misc/qcom-dcc.c
> > 
> > Gentle Ping
> 
> Thank you for the reminder Souradeep. Greg and others, please see if we need
> any changes here or it can be picked up?

It would help if the code would actually build:

drivers/misc/qcom-dcc.c: In function ‘ready_read’:
drivers/misc/qcom-dcc.c:853:13: error: unused variable ‘ret’ [-Werror=unused-variable]
  853 |         int ret = 0;
      |             ^~~

{sigh}

How in the world was this ever tested?

greg k-h
