Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0B754BCA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 21:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjGOTmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 15:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjGOTmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 15:42:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9070DFA;
        Sat, 15 Jul 2023 12:42:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2078760C19;
        Sat, 15 Jul 2023 19:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF41EC433C7;
        Sat, 15 Jul 2023 19:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689450132;
        bh=L9Aaltyydga/bTFQ8BLKtdIomzuVw5oW9rkI/Tup270=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GliesZC722hQaaQaKpku/XcrJQp9uwQgl5Km+oiUUb4hjudl7WmA+bsristbqM9RJ
         a9hGetP8C1I95ytX3nkMka1/CA3Co+X4l55yL9N1O2RPpPEz4dXaDna1vBppYaaILk
         pw7nFypfpL477Sy3Zg/WPtlukm5HRI1JKQW4vTqcsThI8RXmDC5sJHzuzj9a1S7gVl
         2ftCcQf6kYKIS/uVEm8x5ZoN9S2Rc/al7TyhRC2up2qAuPQAUcJVBSdqC1OYK4cQZN
         giEppaIBCpV3gRf8VPyPdhh5hJfjRHYpggeDxJ+rAdmuEJp8ZAxrvmqYBUuMPRBX80
         nxuGgG01o6lqg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_bjorande@quicinc.com, arnaud.pouliquen@foss.st.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        mathieu.poirier@linaro.org, Sarannya S <quic_sarannya@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Sarannya S <sarannya@qti.qualcomm.com>
Subject: Re: [PATCH V9 0/3] rpmsg signaling/flowcontrol patches
Date:   Sat, 15 Jul 2023 12:45:35 -0700
Message-ID: <168945033422.1736171.12944581694054253957.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <1688679698-31274-1-git-send-email-quic_sarannya@quicinc.com>
References: <1688679698-31274-1-git-send-email-quic_sarannya@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Jul 2023 03:11:35 +0530, Sarannya S wrote:
> From: Sarannya S <sarannya@qti.qualcomm.com>
> 
> Changes from V8:
> * Updated the argument for RPMSG_SET_INCOMING_FLOWCONTROL to int.
> * Return -EINVAL if arg > 1 in RPMSG_SET_INCOMING_FLOWCONTROL.
> 
> Key changes from earlier revisions:
> * Added two new RPMSG IOCTLs for rpmsg_char- RPMSG_GET_SIGNAL_IOCTRL and RPMSG_SET_SIGNAL_IOCTRL, to set/get the flow.
> * Updated the cmd name 'RPM_CMD_SIGNALS' to 'GLINK_CMD_SIGNALS'.
> * Return EOPNOTSUPP error in rpmsg_set_flow_control(), if the backend does not support flow control ops.
> * For rpmsg_set_flow_control, change "EXPORT_SYMBOL" to "EXPORT_SYMBOL_GPL".
> * Change return type of qcom_glink_handle_signals() from int to void.
> * Added destination address of the endpoint as parameter in rpmsg_set_flow_control.
> * Changed 'remote_flow' to bool type, and updated it's evaluation.
> * Updated evaluation of 'set' in rpmsg_char as 'set = !!arg'.
> 
> [...]

Applied, thanks!

[1/3] rpmsg: core: Add signal API support
      commit: 8ce49c2a2aa53afde9a20a8ce02b069d3b262af0
[2/3] rpmsg: glink: Add support to handle signals command
      commit: a2b73aa512a4a90dda7dd5bb38b26b4f1381adbb
[3/3] rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support
      commit: 5550201c0fe26a76c53983bd36a58d4c4395ec22

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
