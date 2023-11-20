Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6788D7F1923
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjKTQxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjKTQxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:53:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10455BA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:53:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55CDC433C7;
        Mon, 20 Nov 2023 16:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700499181;
        bh=0Ltci87TG8iej+bFg5HVGpZD7dydE73T+Xze/XK8NW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3IyRYIjl5nbe0JjSWG/SnQsghzoMD1vpyTCHWlo9a+u4Kmdc4tshhqNZtSoOhfEW
         OgBx1DR41+Ta6nGT9qkG3HZGM2JqXC/xSGLMEhW4OunYNZQERumukoZsIkd6U+8teY
         lgfCi17hUo+f0/5qNQPpAFbTInadrahL8vAvsduEX3He84O4m0PJ27z2BNVsXEUkG4
         zxsx+ULMm0OD4hMry37SwY7KJqRUEltkCQBCceFixmR/tnWkhvhhGhjaI6CL8BK3I9
         tM4dLNlJtbWzRZanqcFVPcXOGW++nHHSlETOG1mnxacnNwOT4G66SrQnyL7SvjbDMP
         /dey0Vu/2+B7Q==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r57WI-0002Az-2C;
        Mon, 20 Nov 2023 17:53:11 +0100
Date:   Mon, 20 Nov 2023 17:53:10 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] USB: dwc3: qcom: fix resource leaks on probe deferral
Message-ID: <ZVuO9qj3SRHAS4qm@hovoldconsulting.com>
References: <20231117173650.21161-1-johan+linaro@kernel.org>
 <041f239f-7b40-4681-8c6c-2268f9c2c684@linaro.org>
 <74cswe5tivcctmnty3gfavzsxdvjz5m4rktyj5auzwvrndninm@dah4h2fdj3zv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74cswe5tivcctmnty3gfavzsxdvjz5m4rktyj5auzwvrndninm@dah4h2fdj3zv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 09:22:54AM -0600, Andrew Halaney wrote:
> On Sat, Nov 18, 2023 at 12:47:30AM +0100, Konrad Dybcio wrote:
> > On 17.11.2023 18:36, Johan Hovold wrote:
> > > When reviewing the recently submitted series which reworks the dwc3 qcom
> > > glue implementation [1], I noticed that the driver's tear down handling
> > > is currently broken, something which can lead to memory leaks and
> > > potentially use-after-free issues on probe deferral and on driver
> > > unbind.
> > > 
> > > Let's get this sorted before reworking driver.
> > > 
> > > Note that the last patch has only been compile tested as I don't have
> > > access to a sdm845 device.

> > I'll sound like a broken record, but:
> > 
> > is there anyone in the world that is actively benefiting from this failed
> > experiment of using the ACPI tables that were shipped with these SoCs?
> > 
> > There are so so so many shortcomings associated with it due to how Windows
> > drivers on these platforms know waaaay too much and largely use ACPI to
> > "bind driver x" and I simply think it doesn't make sense to continue
> > carrying this code forward given little use and no testing.

> For what it is worth, I have agreed with your opinion on this every time
> I've read it. I am not the target audience of the question, but I'll at
> least give my personal (interpreted: uneducated? undesired?) opinion
> that the ACPI support in here adds little value and extra burden.
> 
> Of course that topic is a bit independent of this series, but I'd be
> curious if a patchset removing the support would be welcomed or not by
> maintainers, so I'm stirring the pot by replying here :)

I agree that if we can remove the ACPI hacks in here, we should try do
so (e.g. given that no one really uses it anymore).

As Andrew already mentioned, that is a separate issue not directly
related to this series, though.

Removing it before reworking the dwc3 binding [1] and adding multiport
support [2] should simplify both of those series quite a bit, however.

Johan

[1] https://lore.kernel.org/all/20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com/
[2] https://lore.kernel.org/all/20231007154806.605-1-quic_kriskura@quicinc.com/
