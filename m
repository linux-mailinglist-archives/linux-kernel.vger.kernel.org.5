Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C6F7BF479
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442499AbjJJHiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442324AbjJJHip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:38:45 -0400
X-Greylist: delayed 578 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 00:38:42 PDT
Received: from mail-m12776.qiye.163.com (mail-m12776.qiye.163.com [115.236.127.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FD892;
        Tue, 10 Oct 2023 00:38:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=iuOR1rivqCbdriJLtUuH+5AviWKmPmv9NtcNnZgyK/tEweYPqHKcQi93OrG0pivQdfFM+ArBKqSY+afNsHis0ByqGoQpc41UgbinMCmD8yBm0aeCzHdYWXlGmR7Hgms14JKAH3+o9ST6y69Mi8K7WzeGfngdDSCrpRx9GFAAtrQ=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=qmWapQdLdKncGvbCY2gNPG9W9lXntl9infBlt1o2S9c=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.213] (unknown [58.22.7.114])
        by mail-m12773.qiye.163.com (Hmail) with ESMTPA id BCBFE2C0A77;
        Tue, 10 Oct 2023 15:28:54 +0800 (CST)
Message-ID: <25956856-018d-4c82-a50e-0df433d8a33c@rock-chips.com>
Date:   Tue, 10 Oct 2023 15:28:54 +0800
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
 <471bd277-3047-4157-a27d-f2fd203fb9b8@rock-chips.com>
 <20231002181852.cfucitjfacf3khnx@synopsys.com>
From:   wuliangfeng <william.wu@rock-chips.com>
In-Reply-To: <20231002181852.cfucitjfacf3khnx@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMfGFYZGUhCGB8aSU0fS0pVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
        tLWQY+
X-HM-Tid: 0a8b187d1ecbb249kuuubcbfe2c0a77
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MhA6OTo5Dzw1IhEVFio#UQIO
        DgMKFC5VSlVKTUJNQklJQkhOTUpOVTMWGhIXVQwSFxcSGhZVDA47CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCSUpPNwY+
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

Sorry for my late reply because the national day holiday.

在 2023/10/3 2:18, Thinh Nguyen 写道:
> On Fri, Sep 15, 2023, wuliangfeng wrote:
>> Hi Thinh,
>>
>> On 2023/9/12 8:08, Thinh Nguyen wrote:
>>> Hi,
>>>
>>> On Mon, Sep 11, 2023, William Wu wrote:
>>>> If we enable PM runtime auto suspend for dwc3 on rockchip
>>>> platforms (e.g. RK3562), it allows the dwc3 controller to
>>>> enter runtime suspend if usb cable detached and power off
>>>> the power domain of the controller. When system resume, if
>>>> the dwc3 already in runtime suspended, it Shouldn't access
>>>> the dwc3 registers in dwc3_resume() because its power domain
>>>> maybe power off.
>>>>
>>>> Test on RK3562 tablet, this patch can help to avoid kernel
>>>> panic when accessing the dwc3 registers in dwc3_resume() if
>>>> the dwc3 is in runtime suspended and it's power domain is
>>>> power off.
>>> The controller should be woken up before this step. Can you provide more
>>> detail on what led to this?
>> Yes, the power domain of the usb controller will be enabled by the framework
>> of  the pm generic domain before dwc3 resume if the system enter suspend and
>> exit suspend normally. However, in my test case，if the system fail to enter
>> suspend because of some devices's problem, and then goto recovery process,
>> the power domain of the usb controller will not be enable before dwc3
>> resume.
> Ok.
>
>>> e.g. some questions:
>>> Who handles the waking up of the controller? Is it the phy driver? Is
>>> the phy driver not detecting a resume? Or did the resume fail? Does this
>>> occur consistently?
>>>
>>> Thanks,
>>> Thinh
>> This issue occurs occasionally on RK3562 EVB with Type-C USB, and enable
>> autosuspend for dwc3 controller.
>>
>> Here is the test steps:
>>
>> 1. Power on the RK3562 EVB and the Type-C USB interface is in unconnected
>> state.
>>
>> 2. Makesure the dwc3 controller enter runtime suspend, and its power domain
>> is disabled.
>>
>> 3. Do system suspend/resume stress test.
>>
>> 4. The issue occurs occasionally  with the following log:
>>
>> [  251.681091][ T4331] PM: suspend entry (deep)
>> [  251.778975][ T4331] Filesystems sync: 0.097 seconds
>> [  251.779025][ T4331] Freezing user space processes ... (elapsed 0.005
>> seconds) done.
>> [  251.784819][ T4331] OOM killer disabled.
>> [  251.784851][ T4331] Freezing remaining freezable tasks ... (elapsed 0.004
>> seconds) done.
>> [  251.792719][  T503] [SKWIFI DBG] skw_suspend: WoW: enabled, skw flags:
>> 0x302
>> [  251.803701][ T4331] PM: dpm_run_callback():
>> platform_pm_suspend.cfi_jt+0x0/0x8 returns -16
>> [  251.803779][   T75] PM: PM: Pending Wakeup Sources: alarmtimer.0.auto
>> [  251.803789][ T4331] PM: Device alarmtimer.0.a
>> [  251.803928][ T4331] PM: Some devices failed to suspend, or early wake
>> event detected
>> [  251.804141][   T75] [SKWIFI DBG] skw_resume: skw flags: 0x300
>> [  251.804715][    C2] SError Interrupt on CPU2, code 0xbf000000 -- SError
>> [  251.804725][    C2] CPU: 2 PID: 4331 Comm: binder:251_4 Tainted: G
>> WC  E 5.10.157-android13-4-00006-g73f337804fbc-ab9881769 #1
>> [  251.804732][    C2] Hardware name: Rockchip RK3562 RK817 TABLET LP4 Board
>> (DT)
>> [  251.804738][    C2] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
>> [  251.804743][    C2] pc : el1_abort+0x40/0x68
>> [  251.804748][    C2] lr : el1_abort+0x28/0x68
>>
>> ......
>>
>> [  251.804965][    C2] Kernel panic - not syncing: Asynchronous SError
>> Interrupt
>> [  251.804974][    C2] CPU: 2 PID: 4331 Comm: binder:251_4 Tainted: G
>> WC  E 5.10.157-android13-4-00006-g73f337804fbc-ab9881769 #1
>> [  251.804980][    C2] Hardware name: Rockchip RK3562 RK817 TABLET LP4 Board
>> (DT)
>> [  251.804984][    C2] Call trace:
>> [  251.804990][    C2]  dump_backtrace.cfi_jt+0x0/0x8
>> [  251.804995][    C2]  dump_stack_lvl+0xc0/0x13c
>> [  251.805000][    C2]  panic+0x174/0x468
>> [  251.805006][    C2]  arm64_serror_panic+0x1b0/0x200
>> [  251.805010][    C2]  do_serror+0x184/0x1e4
>> [  251.805016][    C2]  el1_error+0x94/0x118
>> [  251.805020][    C2]  el1_abort+0x40/0x68
>> [  251.805026][    C2]  el1_sync_handler+0x58/0x88
>> [  251.805031][    C2]  el1_sync+0x8c/0x140
>> [  251.805035][    C2]  dwc3_readl+0x30/0x1a0
>> [  251.805040][    C2]  dwc3_phy_setup+0x38/0x510
>> [  251.805045][    C2]  dwc3_core_init+0x68/0xcd4
>> [  251.805051][    C2]  dwc3_core_init_for_resume+0x10c/0x25c
>> [  251.805056][    C2]  dwc3_resume_common+0x44/0x3d0
>> [  251.805061][    C2]  dwc3_resume+0x5c/0xb8
>> [  251.805067][    C2]  dpm_run_callback+0x70/0x488
>> [  251.805071][    C2]  device_resume+0x250/0x2f8
>> [  251.805077][    C2]  dpm_resume+0x258/0x9dc
>> [  251.805082][    C2]  suspend_devices_and_enter+0x850/0xcac
>>
>> In this case, during suspend process, because the device alarmtimer failed
>> to suspend, it break the system suspend in the funciton
>> suspend_devices_and_enter(), and goto platform_recover() directly without
>> enable the power domain of the controller, then trigger the Kernel panic in
>> dwc3_resume().
>>
> Thanks for the details.
>
>> For a comparison, in the normal case, if the system enter suspend normally,
>> and after the system wakeup, the power domain of the controller will be
>> enable by the framework of  the pm generic domain before dwc3 resume.
>>
>> The function call stack like this:
>>
>> suspend_devices_and_enter -->
>>
>>      suspend_enter -->
>>
>>           dpm_resume_noirq --> dpm_noirq_resume_devices -->
>> device_resume_noirq --> genpd_resume_noirq --> rockchip_pd_power （enable
>> the power domain of the controller）
>>
>>      dpm_resume_end -->
>>
>>           dpm_resume --> device_resume --> dpm_run_callback --> dwc3_resume
>> (access the controller safely)
>>
>>           dpm_complete --> genpd_complete --> genpd_queue_power_off_work
>>
>> suspend_finish --> suspend_thaw_processes --> genpd_power_off_work_fn -->
>> (diable the power domain of the controller to maintain the original runtime
>> suspend state)
>>
> At what step do we restore the power domain when this happen? Looks like
> there's a missing step in the suspend failure recovery to recover the
> power domain. What we're doing here seems more like a workaround to
> that, which unfortunately makes the code logic looks unclear IMO.

When then suspend successful, the power framework call 
dpm_resume_noirq() to enable on the power domain and then call 
dpm_complete() -> genpd_power_off_work_fn() to restore the original 
power domain state.

When the suspend failure happens，it seems that nobody recover the power 
domain in the power framework and rockchip platform pm_domains driver.

>
> Can this be fixed in the lower layer?

For the time being, I haven't found a solution in the lower layer to fix 
this issue. I have to disable the dwc3 runtime feature on RK3562 GKI 
project.

>
> Thanks,
> Thinh
