Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2D97A2327
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbjIOQBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbjIOQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:00:56 -0400
X-Greylist: delayed 422 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Sep 2023 09:00:11 PDT
Received: from mail-m49227.qiye.163.com (mail-m49227.qiye.163.com [45.254.49.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9291B2D64;
        Fri, 15 Sep 2023 09:00:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=b38iHaZW11Obeoep46pVsdPnzK8Hi3vY2j8FBDvuf6NFpNKa3ZOTIDWTGvZf1m5jm7v9wvYaD97IfnUlJ9msBxfL7LD0Qp9Uzb9BGAIJIp+BeuYAsXaFxBMSiIKsCqTYagzOdbONcPmY8YJVj34/fCi28hkWd1N0X+DOjuMa2Q4=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=Dfd3pIm8sRcvgPlo2tega07NPBHgrA1NQnilsqUXb1s=;
        h=date:mime-version:subject:message-id:from;
Received: from [10.10.10.174] (unknown [61.241.200.242])
        by mail-m12785.qiye.163.com (Hmail) with ESMTPA id F2D30B808F0;
        Fri, 15 Sep 2023 23:53:05 +0800 (CST)
Message-ID: <471bd277-3047-4157-a27d-f2fd203fb9b8@rock-chips.com>
Date:   Fri, 15 Sep 2023 23:53:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: core: Avoid resume dwc3 if already
 suspended in pm resume
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frank.wang@rock-chips.com" <frank.wang@rock-chips.com>,
        "jianwei.zheng@rock-chips.com" <jianwei.zheng@rock-chips.com>,
        "yangbin@rock-chips.com" <yangbin@rock-chips.com>
References: <20230911033112.3321-1-william.wu@rock-chips.com>
 <20230912000802.nb5mk4e5toojyqis@synopsys.com>
From:   wuliangfeng <william.wu@rock-chips.com>
In-Reply-To: <20230912000802.nb5mk4e5toojyqis@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQkJNVk0ZSU5OQhlMTx4YQlUTARMWGhIXJBQOD1
        lXWRgSC1lBWU1KVUlPSlVJS0tVSU9JWVdZFhoPEhUdFFlBWU9LSFVKSEpCSE9VSktLVUtZBg++
X-HM-Tid: 0a8a998bbb9fb255kuuuf2d30b808f0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N0k6Fjo*AT1CKwEuNCI4EhVL
        Oh8aCThVSlVKTUJPTEJISkNNTEJPVTMWGhIXVQwSFxcSGhZVDA47CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlNSlVJT0pVSUtLVUlPSVlXWQgBWUFCSUlCNwY+
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 2023/9/12 8:08, Thinh Nguyen wrote:
> Hi,
>
> On Mon, Sep 11, 2023, William Wu wrote:
>> If we enable PM runtime auto suspend for dwc3 on rockchip
>> platforms (e.g. RK3562), it allows the dwc3 controller to
>> enter runtime suspend if usb cable detached and power off
>> the power domain of the controller. When system resume, if
>> the dwc3 already in runtime suspended, it Shouldn't access
>> the dwc3 registers in dwc3_resume() because its power domain
>> maybe power off.
>>
>> Test on RK3562 tablet, this patch can help to avoid kernel
>> panic when accessing the dwc3 registers in dwc3_resume() if
>> the dwc3 is in runtime suspended and it's power domain is
>> power off.
> The controller should be woken up before this step. Can you provide more
> detail on what led to this?

Yes, the power domain of the usb controller will be enabled by the 
framework of  the pm generic domain before dwc3 resume if the system 
enter suspend and exit suspend normally. However, in my test case，if the 
system fail to enter suspend because of some devices's problem, and then 
goto recovery process, the power domain of the usb controller will not 
be enable before dwc3 resume.

> e.g. some questions:
> Who handles the waking up of the controller? Is it the phy driver? Is
> the phy driver not detecting a resume? Or did the resume fail? Does this
> occur consistently?
>
> Thanks,
> Thinh

This issue occurs occasionally on RK3562 EVB with Type-C USB, and enable 
autosuspend for dwc3 controller.

Here is the test steps:

1. Power on the RK3562 EVB and the Type-C USB interface is in 
unconnected state.

2. Makesure the dwc3 controller enter runtime suspend, and its power 
domain is disabled.

3. Do system suspend/resume stress test.

4. The issue occurs occasionally  with the following log:

[  251.681091][ T4331] PM: suspend entry (deep)
[  251.778975][ T4331] Filesystems sync: 0.097 seconds
[  251.779025][ T4331] Freezing user space processes ... (elapsed 0.005 
seconds) done.
[  251.784819][ T4331] OOM killer disabled.
[  251.784851][ T4331] Freezing remaining freezable tasks ... (elapsed 
0.004 seconds) done.
[  251.792719][  T503] [SKWIFI DBG] skw_suspend: WoW: enabled, skw 
flags: 0x302
[  251.803701][ T4331] PM: dpm_run_callback(): 
platform_pm_suspend.cfi_jt+0x0/0x8 returns -16
[  251.803779][   T75] PM: PM: Pending Wakeup Sources: alarmtimer.0.auto
[  251.803789][ T4331] PM: Device alarmtimer.0.a
[  251.803928][ T4331] PM: Some devices failed to suspend, or early wake 
event detected
[  251.804141][   T75] [SKWIFI DBG] skw_resume: skw flags: 0x300
[  251.804715][    C2] SError Interrupt on CPU2, code 0xbf000000 -- SError
[  251.804725][    C2] CPU: 2 PID: 4331 Comm: binder:251_4 Tainted: 
G        WC  E 5.10.157-android13-4-00006-g73f337804fbc-ab9881769 #1
[  251.804732][    C2] Hardware name: Rockchip RK3562 RK817 TABLET LP4 
Board (DT)
[  251.804738][    C2] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
[  251.804743][    C2] pc : el1_abort+0x40/0x68
[  251.804748][    C2] lr : el1_abort+0x28/0x68

......

[  251.804965][    C2] Kernel panic - not syncing: Asynchronous SError 
Interrupt
[  251.804974][    C2] CPU: 2 PID: 4331 Comm: binder:251_4 Tainted: 
G        WC  E 5.10.157-android13-4-00006-g73f337804fbc-ab9881769 #1
[  251.804980][    C2] Hardware name: Rockchip RK3562 RK817 TABLET LP4 
Board (DT)
[  251.804984][    C2] Call trace:
[  251.804990][    C2]  dump_backtrace.cfi_jt+0x0/0x8
[  251.804995][    C2]  dump_stack_lvl+0xc0/0x13c
[  251.805000][    C2]  panic+0x174/0x468
[  251.805006][    C2]  arm64_serror_panic+0x1b0/0x200
[  251.805010][    C2]  do_serror+0x184/0x1e4
[  251.805016][    C2]  el1_error+0x94/0x118
[  251.805020][    C2]  el1_abort+0x40/0x68
[  251.805026][    C2]  el1_sync_handler+0x58/0x88
[  251.805031][    C2]  el1_sync+0x8c/0x140
[  251.805035][    C2]  dwc3_readl+0x30/0x1a0
[  251.805040][    C2]  dwc3_phy_setup+0x38/0x510
[  251.805045][    C2]  dwc3_core_init+0x68/0xcd4
[  251.805051][    C2]  dwc3_core_init_for_resume+0x10c/0x25c
[  251.805056][    C2]  dwc3_resume_common+0x44/0x3d0
[  251.805061][    C2]  dwc3_resume+0x5c/0xb8
[  251.805067][    C2]  dpm_run_callback+0x70/0x488
[  251.805071][    C2]  device_resume+0x250/0x2f8
[  251.805077][    C2]  dpm_resume+0x258/0x9dc
[  251.805082][    C2]  suspend_devices_and_enter+0x850/0xcac

In this case, during suspend process, because the device alarmtimer 
failed to suspend, it break the system suspend in the funciton 
suspend_devices_and_enter(), and goto platform_recover() directly 
without enable the power domain of the controller, then trigger the 
Kernel panic in dwc3_resume().


For a comparison, in the normal case, if the system enter suspend 
normally, and after the system wakeup, the power domain of the 
controller will be enable by the framework of  the pm generic domain 
before dwc3 resume.

The function call stack like this:

suspend_devices_and_enter -->

     suspend_enter -->

          dpm_resume_noirq --> dpm_noirq_resume_devices --> 
device_resume_noirq --> genpd_resume_noirq --> rockchip_pd_power （enable 
the power domain of the controller）

     dpm_resume_end -->

          dpm_resume --> device_resume --> dpm_run_callback --> 
dwc3_resume (access the controller safely)

          dpm_complete --> genpd_complete --> genpd_queue_power_off_work

suspend_finish --> suspend_thaw_processes --> genpd_power_off_work_fn 
--> (diable the power domain of the controller to maintain the original 
runtime  suspend state)


Thanks,

William

>
>> Kernel panic - not syncing: Asynchronous SError Interrupt
>> Hardware name: Rockchip RK3562 RK817 TABLET LP4 Board (DT)
>> Call trace:
>> dump_backtrace.cfi_jt+0x0/0x8
>>    dump_stack_lvl+0xc0/0x13c
>>    panic+0x174/0x468
>>    arm64_serror_panic+0x1b0/0x200
>>    do_serror+0x184/0x1e4
>>    el1_error+0x94/0x118
>>    el1_abort+0x40/0x68
>>    el1_sync_handler+0x58/0x88
>>    el1_sync+0x8c/0x140
>>    dwc3_readl+0x30/0x1a0
>>    dwc3_phy_setup+0x38/0x510
>>    dwc3_core_init+0x68/0xcd4
>>    dwc3_core_init_for_resume+0x10c/0x25c
>>    dwc3_resume_common+0x44/0x3d0
>>    dwc3_resume+0x5c/0xb8
>>    dpm_run_callback+0x70/0x488
>>    device_resume+0x250/0x2f8
>>    dpm_resume+0x258/0x9dc
>>
>> Signed-off-by: William Wu <william.wu@rock-chips.com>
>> ---
>> Changes in v2:
>> - Remove Change-Id.
>>
>>   drivers/usb/dwc3/core.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 9c6bf054f15d..8274a44f2d6a 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -2185,9 +2185,11 @@ static int dwc3_resume(struct device *dev)
>>   
>>   	pinctrl_pm_select_default_state(dev);
>>   
>> -	ret = dwc3_resume_common(dwc, PMSG_RESUME);
>> -	if (ret)
>> -		return ret;
>> +	if (!pm_runtime_suspended(dwc->dev)) {
>> +		ret = dwc3_resume_common(dwc, PMSG_RESUME);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>>   	pm_runtime_disable(dev);
>>   	pm_runtime_set_active(dev);
>> -- 
>> 2.17.1
