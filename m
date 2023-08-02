Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D0B76D020
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjHBOeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjHBOef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:34:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCB51723;
        Wed,  2 Aug 2023 07:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35133619C0;
        Wed,  2 Aug 2023 14:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575C0C433C7;
        Wed,  2 Aug 2023 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690986867;
        bh=OztTe/JGYQKST5Rzx0ZT6amRzhDvaMGUqnIJE6VGx4g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YohbpaZyHT0oorRTEkwl4f/3SeZ1NyGum898k1JuJYOpJ4n9jkqLM8G1Fl9aGiJu2
         tIi//knk87P+fmP2wsB4L2+5Mb9SZ76YXhupsgh4yIavybNpYEtorFGw8pT7Er3P1W
         jNdKtblXPyX2IQBRbgaa8DxBO5oc90Xl1jF4MkQaRhEEUr1tmpr7kQNAVASTxOuX4g
         GpHkCC5QoNjx5VYhtETBO7RQ12xvzJ9XZlRNpTqlk0yd64+eFA4xHARxcKNHWPWKWa
         D5X4T/XXHT3HT71OY61z/xJd7IC/4yCCt85vKva3gd74hatJ9ysA/lXwhNhNd+owui
         Iigk4K4170y2g==
Message-ID: <50b82871-6308-21e1-77db-0c8793df196d@kernel.org>
Date:   Wed, 2 Aug 2023 17:34:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: dwc3: Properly handle processing of pending events
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        felipe.balbi@linux.intel.com, surong.pang@unisoc.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        stable@vger.kernel.org
References: <20230801192658.19275-1-quic_eserrao@quicinc.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230801192658.19275-1-quic_eserrao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2023 22:26, Elson Roy Serrao wrote:
> If dwc3 is runtime suspended we defer processing the event buffer
> until resume, by setting the pending_events flag. Set this flag before
> triggering resume to avoid race with the runtime resume callback.
> 
> While handling the pending events, in addition to checking the event
> buffer we also need to process it. Handle this by explicitly calling
> dwc3_thread_interrupt(). Also balance the runtime pm get() operation
> that triggered this processing.
> 
> Cc: stable@vger.kernel.org
> Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
