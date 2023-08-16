Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A0277DD77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbjHPJjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243351AbjHPJjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:39:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B2D13E;
        Wed, 16 Aug 2023 02:39:40 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:73f6:2283:f432:3936] (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4E4CE66071DF;
        Wed, 16 Aug 2023 10:39:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692178779;
        bh=f1VqzkUzd6qxjYJQ57s+hzeAAoTbE5E5LX9b0VNYtCg=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=bWtTrQuHFCKKH565ZRcQZoWb0b7Y6YSj7nPsqf9K5TWxFiDSRm037UbcXufiA/2dl
         XWgB+nx1okTTSn0lABiYcRrtIh55zKliGsk7Lh6dtVAO2OhsKr34evTi4zC6IZB2fq
         SQp1y3nPIcz146TpZD/UerPxgUD4vWocU7p3lxygjrF212UggvUk1pzSHIg2E7lpbh
         Omg83I5MTu5l4tCX6e8XGzvI9FsULgdVoJ9jhLpCtDdI0QYuxKd4RLJ69LLd/ng6AB
         0l8tSMDbbJQVF6pLEMzVnyrH67IQ92yZFMgWTSDz9RzZuc4qlFTMvu9rj3rC/3V6zG
         ksdhNx8W1G2YQ==
Message-ID: <6283c4b1-2513-207d-4ed6-fdabf3f3880e@collabora.com>
Date:   Wed, 16 Aug 2023 15:09:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Shreeya Patel <shreeya.patel@collabora.com>
Subject: Re: [PATCH 5.17 127/298] driver core: Fix wait_for_device_probe() &
 deferred_probe_timeout interaction
To:     saravanak@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, John Stultz <jstultz@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        =?UTF-8?Q?Ricardo_Ca=c3=b1uelo_Navarro?= 
        <ricardo.canuelo@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        usama.anjum@collabora.com, kernelci@lists.linux.dev
References: <20220613094924.913340374@linuxfoundation.org>
 <20220613094928.793712131@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20220613094928.793712131@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/22 15:40, Greg Kroah-Hartman wrote:
> From: Saravana Kannan<saravanak@google.com>
>
> [ Upstream commit 5ee76c256e928455212ab759c51d198fedbe7523 ]
>
> Mounting NFS rootfs was timing out when deferred_probe_timeout was
> non-zero [1].  This was because ip_auto_config() initcall times out
> waiting for the network interfaces to show up when
> deferred_probe_timeout was non-zero. While ip_auto_config() calls
> wait_for_device_probe() to make sure any currently running deferred
> probe work or asynchronous probe finishes, that wasn't sufficient to
> account for devices being deferred until deferred_probe_timeout.
>
> Commit 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits
> until the deferred_probe_timeout fires") tried to fix that by making
> sure wait_for_device_probe() waits for deferred_probe_timeout to expire
> before returning.
>
> However, if wait_for_device_probe() is called from the kernel_init()
> context:
>
> - Before deferred_probe_initcall() [2], it causes the boot process to
>    hang due to a deadlock.
>
> - After deferred_probe_initcall() [3], it blocks kernel_init() from
>    continuing till deferred_probe_timeout expires and beats the point of
>    deferred_probe_timeout that's trying to wait for userspace to load
>    modules.
>
> Neither of this is good. So revert the changes to
> wait_for_device_probe().
>
> [1] -https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com/
> [2] -https://lore.kernel.org/lkml/YowHNo4sBjr9ijZr@dev-arch.thelio-3990X/
> [3] -https://lore.kernel.org/lkml/Yo3WvGnNk3LvLb7R@linutronix.de/

Hi Saravana, Greg,


KernelCI found this patch causes the baseline.bootrr.deferred-probe-empty test to fail on r8a77960-ulcb,
see the following details for more information.

KernelCI dashboard link:
https://linux.kernelci.org/test/plan/id/64d2a6be8c1a8435e535b264/

Error messages from the logs :-

+ UUID=11236495_1.5.2.4.5
+ set +x
+ export 'PATH=/opt/bootrr/libexec/bootrr/helpers:/lava-11236495/1/../bin:/sbin:/usr/sbin:/bin:/usr/bin'
+ cd /opt/bootrr/libexec/bootrr
+ sh helpers/bootrr-auto
e6800000.ethernet	
e6700000.dma-controller	
e7300000.dma-controller	
e7310000.dma-controller	
ec700000.dma-controller	
ec720000.dma-controller	
fea20000.vsp	
feb00000.display	
fea28000.vsp	
fea30000.vsp	
fe9a0000.vsp	
fe9af000.fcp	
fea27000.fcp	
fea2f000.fcp	
fea37000.fcp	
sound	
ee100000.mmc	
ee140000.mmc	
ec500000.sound	
/lava-11236495/1/../bin/lava-test-case
<8>[   17.476741] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=deferred-probe-empty RESULT=fail>

Test case failing :-
Baseline Bootrr deferred-probe-empty test -https://github.com/kernelci/bootrr/blob/main/helpers/bootrr-generic-tests

Regression Reproduced :-

Lava job after reverting the commit 5ee76c256e92
https://lava.collabora.dev/scheduler/job/11292890


Bisection report from KernelCI can be found at the bottom of the email.

Thanks,
Shreeya Patel

#regzbot introduced: 5ee76c256e92
#regzbot title: KernelCI: Multiple devices deferring on r8a77960-ulcb

---------------------------------------------------------------------------------------------------------------------------------------------------

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * **
* If you do send a fix, please include this trailer: *
* Reported-by: "kernelci.org bot" <bot@...> *
* *
* Hope this helps! *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

stable-rc/linux-5.10.y bisection: baseline.bootrr.deferred-probe-empty 
on r8a77960-ulcb

Summary:
Start: 686c84f2f136 Linux 5.10.189-rc1
Plain log: 
https://storage.kernelci.org/stable-rc/linux-5.10.y/v5.10.188-183-g686c84f2f1364/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
HTML log: 
https://storage.kernelci.org/stable-rc/linux-5.10.y/v5.10.188-183-g686c84f2f1364/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
Result: 71cbce75031a driver core: Fix wait_for_device_probe() & 
deferred_probe_timeout interaction

Checks:
revert: PASS
verify: PASS

Parameters:
Tree: stable-rc
URL: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
Branch: linux-5.10.y
Target: r8a77960-ulcb
CPU arch: arm64
Lab: lab-collabora
Compiler: gcc-10
Config: defconfig
Test case: baseline.bootrr.deferred-probe-empty

Breaking commit found:

-------------------------------------------------------------------------------
commit 71cbce75031aed26c72c2dc8a83111d181685f1b
Author: Saravana Kannan <saravanak@...>
Date: Fri Jun 3 13:31:37 2022 +0200

driver core: Fix wait_for_device_probe() & deferred_probe_timeout 
interaction

[ Upstream commit 5ee76c256e928455212ab759c51d198fedbe7523 ]

Mounting NFS rootfs was timing out when deferred_probe_timeout was
non-zero [1]. This was because ip_auto_config() initcall times out
waiting for the network interfaces to show up when
deferred_probe_timeout was non-zero. While ip_auto_config() calls
wait_for_device_probe() to make sure any currently running deferred
probe work or asynchronous probe finishes, that wasn't sufficient to
account for devices being deferred until deferred_probe_timeout.

Commit 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits
until the deferred_probe_timeout fires") tried to fix that by making
sure wait_for_device_probe() waits for deferred_probe_timeout to expire
before returning.

However, if wait_for_device_probe() is called from the kernel_init()
context:

- Before deferred_probe_initcall() [2], it causes the boot process to
hang due to a deadlock.

- After deferred_probe_initcall() [3], it blocks kernel_init() from
continuing till deferred_probe_timeout expires and beats the point of
deferred_probe_timeout that's trying to wait for userspace to load
modules.

Neither of this is good. So revert the changes to
wait_for_device_probe().

[1] - 
https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com/
[2] - https://lore.kernel.org/lkml/YowHNo4sBjr9ijZr@dev-arch.thelio-3990X/
[3] - https://lore.kernel.org/lkml/Yo3WvGnNk3LvLb7R@linutronix.de/

Fixes: 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits 
until the deferred_probe_timeout fires")
Cc: John Stultz <jstultz@...>
Cc: "David S. Miller" <davem@...>
Cc: Alexey Kuznetsov <kuznet@...>
Cc: Hideaki YOSHIFUJI <yoshfuji@...>
Cc: Jakub Kicinski <kuba@...>
Cc: Rob Herring <robh@...>
Cc: Geert Uytterhoeven <geert@...>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@...>
Cc: Robin Murphy <robin.murphy@...>
Cc: Andy Shevchenko <andy.shevchenko@...>
Cc: Sudeep Holla <sudeep.holla@...>
Cc: Andy Shevchenko <andriy.shevchenko@...>
Cc: Naresh Kamboju <naresh.kamboju@...>
Cc: Basil Eljuse <Basil.Eljuse@...>
Cc: Ferry Toth <fntoth@...>
Cc: Arnd Bergmann <arnd@...>
Cc: Anders Roxell <anders.roxell@...>
Cc: linux-pm@...
Reported-by: Nathan Chancellor <nathan@...>
Reported-by: Sebastian Andrzej Siewior <bigeasy@...>
Tested-by: Geert Uytterhoeven <geert+renesas@...>
Acked-by: John Stultz <jstultz@...>
Signed-off-by: Saravana Kannan <saravanak@...>
Link: https://lore.kernel.org/r/20220526034609.480766-2-saravanak@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@...>
Reviewed-by: Rafael J. Wysocki <rafael@...>
Signed-off-by: Linus Torvalds <torvalds@...>
Signed-off-by: Sasha Levin <sashal@...>

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 4f4e8aedbd2c..f9d9f1ad9215 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -250,7 +250,6 @@ DEFINE_SHOW_ATTRIBUTE(deferred_devs);

int driver_deferred_probe_timeout;
EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
-static DECLARE_WAIT_QUEUE_HEAD(probe_timeout_waitqueue);

static int __init deferred_probe_timeout_setup(char *str)
{
@@ -302,7 +301,6 @@ static void deferred_probe_timeout_work_func(struct 
work_struct *work)
list_for_each_entry(p, &deferred_probe_pending_list, deferred_probe)
dev_info(p->device, "deferred probe pending\n");
mutex_unlock(&deferred_probe_mutex);
- wake_up_all(&probe_timeout_waitqueue);
}
static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, 
deferred_probe_timeout_work_func);

@@ -706,9 +704,6 @@ int driver_probe_done(void)
*/
void wait_for_device_probe(void)
{
- /* wait for probe timeout */
- wait_event(probe_timeout_waitqueue, !driver_deferred_probe_timeout);
-
/* wait for the deferred probe workqueue to finish */
flush_work(&deferred_probe_work);
-------------------------------------------------------------------------------


Git bisection log:

-------------------------------------------------------------------------------
git bisect start
# good: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
git bisect good 2c85ebc57b3e1817b6ce1a6b703928e113a90442
# bad: [686c84f2f136412631eb684b064def993a96a8cc] Linux 5.10.189-rc1
git bisect bad 686c84f2f136412631eb684b064def993a96a8cc
# good: [88f1b613c37fbd3c4171f5a9decdcd12ae704637] Bluetooth: cmtp: fix 
possible panic when cmtp_init_sockets() fails
git bisect good 88f1b613c37fbd3c4171f5a9decdcd12ae704637
# bad: [6c5742372b2d5d36de129439e26eda05aab54652] Input: snvs_pwrkey - 
fix SNVS_HPVIDR1 register address
git bisect bad 6c5742372b2d5d36de129439e26eda05aab54652
# good: [07280d2c3f33d47741f42411eb8c976b70c6657a] random: make more 
consistent use of integer types
git bisect good 07280d2c3f33d47741f42411eb8c976b70c6657a
# bad: [2fc7f18ba2f98d15f174ce8e25a5afa46926eb55] tools headers: Remove 
broken definition of __LITTLE_ENDIAN
git bisect bad 2fc7f18ba2f98d15f174ce8e25a5afa46926eb55
# bad: [c2ae49a113a5344232f1ebb93bcf18bbd11e9c39] net: dsa: 
lantiq_gswip: Fix refcount leak in gswip_gphy_fw_list
git bisect bad c2ae49a113a5344232f1ebb93bcf18bbd11e9c39
# good: [c1b08aa568e829b743affe5d3231e6de28b7609e] ASoC: samsung: Use 
dev_err_probe() helper
git bisect good c1b08aa568e829b743affe5d3231e6de28b7609e
# good: [97a9ec86ccb4e336ecde46db42b59b2ff7e0d719] drm/nouveau/clk: Fix 
an incorrect NULL check on list iterator
git bisect good 97a9ec86ccb4e336ecde46db42b59b2ff7e0d719
# good: [572211d631d7665c6690b5a6cb80436f8c368dc1] pwm: lp3943: Fix duty 
calculation in case period was clamped
git bisect good 572211d631d7665c6690b5a6cb80436f8c368dc1
# good: [8f49e1694cbc29e76d5028267c1978cc2630e494] bpf: Fix probe read 
error in ___bpf_prog_run()
git bisect good 8f49e1694cbc29e76d5028267c1978cc2630e494
# bad: [3660db29b0305f9a1d95979c7af0f5db6ea99f5d] iommu/arm-smmu: fix 
possible null-ptr-deref in arm_smmu_device_probe()
git bisect bad 3660db29b0305f9a1d95979c7af0f5db6ea99f5d
# good: [04622d631826ba483ae3a0b8a71c745d8e21453d] gpio: pca953x: use 
the correct register address to do regcache sync
git bisect good 04622d631826ba483ae3a0b8a71c745d8e21453d
# bad: [32be2b805a1a13ccc68bd209ec3ae198dd3ba5d6] perf c2c: Fix sorting 
in percent_rmt_hitm_cmp()
git bisect bad 32be2b805a1a13ccc68bd209ec3ae198dd3ba5d6
# good: [c1f0187025905e9981000d44a92e159468b561a8] scsi: sd: Fix 
potential NULL pointer dereference
git bisect good c1f0187025905e9981000d44a92e159468b561a8
# bad: [71cbce75031aed26c72c2dc8a83111d181685f1b] driver core: Fix 
wait_for_device_probe() & deferred_probe_timeout interaction
git bisect bad 71cbce75031aed26c72c2dc8a83111d181685f1b
# good: [b8fac8e321044a9ac50f7185b4e9d91a7745e4b0] tipc: check attribute 
length for bearer name
git bisect good b8fac8e321044a9ac50f7185b4e9d91a7745e4b0
# first bad commit: [71cbce75031aed26c72c2dc8a83111d181685f1b] driver 
core: Fix wait_for_device_probe() & deferred_probe_timeout interaction
-------------------------------------------------------------------------------


> Fixes: 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits until the deferred_probe_timeout fires")
> Cc: John Stultz<jstultz@google.com>
> Cc: "David S. Miller"<davem@davemloft.net>
> Cc: Alexey Kuznetsov<kuznet@ms2.inr.ac.ru>
> Cc: Hideaki YOSHIFUJI<yoshfuji@linux-ipv6.org>
> Cc: Jakub Kicinski<kuba@kernel.org>
> Cc: Rob Herring<robh@kernel.org>
> Cc: Geert Uytterhoeven<geert@linux-m68k.org>
> Cc: Yoshihiro Shimoda<yoshihiro.shimoda.uh@renesas.com>
> Cc: Robin Murphy<robin.murphy@arm.com>
> Cc: Andy Shevchenko<andy.shevchenko@gmail.com>
> Cc: Sudeep Holla<sudeep.holla@arm.com>
> Cc: Andy Shevchenko<andriy.shevchenko@linux.intel.com>
> Cc: Naresh Kamboju<naresh.kamboju@linaro.org>
> Cc: Basil Eljuse<Basil.Eljuse@arm.com>
> Cc: Ferry Toth<fntoth@gmail.com>
> Cc: Arnd Bergmann<arnd@arndb.de>
> Cc: Anders Roxell<anders.roxell@linaro.org>
> Cc:linux-pm@vger.kernel.org
> Reported-by: Nathan Chancellor<nathan@kernel.org>
> Reported-by: Sebastian Andrzej Siewior<bigeasy@linutronix.de>
> Tested-by: Geert Uytterhoeven<geert+renesas@glider.be>
> Acked-by: John Stultz<jstultz@google.com>
> Signed-off-by: Saravana Kannan<saravanak@google.com>
> Link:https://lore.kernel.org/r/20220526034609.480766-2-saravanak@google.com
> Signed-off-by: Greg Kroah-Hartman<gregkh@linuxfoundation.org>
> Reviewed-by: Rafael J. Wysocki<rafael@kernel.org>
> Signed-off-by: Linus Torvalds<torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin<sashal@kernel.org>
> ---
>   drivers/base/dd.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 977e94cf669e..86fd2ea35656 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -257,7 +257,6 @@ DEFINE_SHOW_ATTRIBUTE(deferred_devs);
>   
>   int driver_deferred_probe_timeout;
>   EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
> -static DECLARE_WAIT_QUEUE_HEAD(probe_timeout_waitqueue);
>   
>   static int __init deferred_probe_timeout_setup(char *str)
>   {
> @@ -312,7 +311,6 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
>   	list_for_each_entry(p, &deferred_probe_pending_list, deferred_probe)
>   		dev_info(p->device, "deferred probe pending\n");
>   	mutex_unlock(&deferred_probe_mutex);
> -	wake_up_all(&probe_timeout_waitqueue);
>   }
>   static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
>   
> @@ -720,9 +718,6 @@ int driver_probe_done(void)
>    */
>   void wait_for_device_probe(void)
>   {
> -	/* wait for probe timeout */
> -	wait_event(probe_timeout_waitqueue, !driver_deferred_probe_timeout);
> -
>   	/* wait for the deferred probe workqueue to finish */
>   	flush_work(&deferred_probe_work);
>   
