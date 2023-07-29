Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B723F768020
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjG2OpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjG2OpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F277A8;
        Sat, 29 Jul 2023 07:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E29960C68;
        Sat, 29 Jul 2023 14:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508D0C433C7;
        Sat, 29 Jul 2023 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690641898;
        bh=QL12BlouQL6SL/16K3BQWHaqMdLYPQQWoX4JVp77nsE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=syeMCZyHW8+qPULHdZwYlK3FKpAZ0W6dlv5r6+5RtHJLBS/QK3m9m0wuGliZEpSEe
         9pouZ2Mi0dNy++wl9e4tbz+cDS3ckBE1QVWP0R796cjSLmecARwg9dM+2SL+U8SrQK
         7TVGJ7/KbZ8esjLptsa/UQUzJM2xwrLbKOUEZWZmrcV3XA8GWmK1zfUPpWKi3Tihv+
         ABUMKvwp8hJnnst7dfNDpzfxHUjSAils9VgtiRWn7N8A8aZ8NMvjBA3ADzHOjghxkq
         FXydPOs+Vm0SpOToHMStZ4girm6ZbRsPkGFUBpwN2cFO1YYO8JKhLlp6yzVl2o73dM
         +QdqGMUsfgYyw==
Date:   Sat, 29 Jul 2023 15:45:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@iit.it>
Cc:     <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andrea.merello@gmail.com>,
        <mkelly@xevo.com>, <jmaneyrol@invensense.com>,
        <francesco.diotalevi@iit.it>
Subject: Re: [RFC] IIO: MPU6050: fix level-triggered IRQ support caused
 crash
Message-ID: <20230729154502.2aec850e@jic23-huawei>
In-Reply-To: <20230726090212.10641-1-andrea.merello@iit.it>
References: <20230726090212.10641-1-andrea.merello@iit.it>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 11:02:12 +0200
Andrea Merello <andrea.merello@iit.it> wrote:

> Updating kernel on my board caused crashes while using a MPU6050, more
> specifically when enabling its trigger. This seems due to commit
> 5ec6486daa98 ("iio:imu: inv_mpu6050: support more interrupt types").
> 
> Since the said commit, the MPU6050 driver supports also level-triggered
> interrupts, other than rising-edge interrupts. Unfortunately
> level-triggered interrupts don't work here [0] causing IRQ floods [1],
> Oopses [2] and crashes. This even affected a previously-working setup [3].
> 
> I have to say that I'm not honestly completely sure how to interpret my
> Oopses, and that they are also pointing to the I2C controller and to the
> serial tty driver somehow. However I think that there is a real problem
> with the said IIO commit anyway; support for level-triggered IRQs seems
> broken to me due to the following reason:
> 
> The handler for MPU6050 hardware IRQ is iio_trigger_generic_data_rdy_poll()
> which doesn't acknowleges the IRQ (i.e. the IRQ line remains asserted); the
> IRQ is acknowledged only in the bottom half of the IIO softIRQ, registered
> with devm_iio_triggered_buffer_setup(), which is inv_mpu6050_read_fifo().

Agreed. iio_trigger_generic_data_rdy_poll() is only suitable for use with
either edge triggered or pulse type interrupts (which are basically edges
as well).  The interrupt handler should not be simply returning IRQ_HANDLED if there
is a need to disable / mask the interrupt (which there always is for a level
interrupt).

> 
> I think that in this way the hardware IRQ is re-enabled before the IRQ is
> acknowledged to the IMU. When the IRQ is level-triggered, the IRQ line
> remains asserted causing the hardware IRQ handler to be reentered,
> generating a (fake) IRQ storm (while when interrupts are edge-triggered the
> IMU just generate one pulse until acknowledgment, I guess).

Makes sense.

> 
> Just adding IRQF_ONESHOT to the hardware IRQ flags apparently doesn't make
> any difference, because it would just defer the IRQ re-enable to the bottom
> half of the very same (hardware) IRQ handler, while, in my understanding,
> here the interrupt acknowledgment happens in the bottom half of the *soft*
> IRQ, which is another IRQ indeed.

Lets go with sort of for that - they are conceptually different interrupts,
but the top half of the pollfunc runs directly from the iio_trigger_poll call
as well masking the downstream interrupts and kicking off their threads.

Key here is that the top IRQ handler is return IRQ_HANDLED so that stuff
is all irrelevant - the interrupt is unmasked.

> 
> The following PoC patch moves the interrupt status register read (which
> also acknowledges the IRQ) to the bottom half of the *hardware* IRQ
> handler, which now becomes a threaded IRQ with the IRQF_ONESHOT flag.
> 
> This seems to work. The softirq handler doesn't hopefully really need to
> look at the interrupt status register because it will give up early anyway
> when it finds no data in the IMU FIFO.
> 
> I have to say that I'm not really sure this is a good way to fix things;
> possibly someone has advices for a better fix (RFC).

One common approach is to mask the interrupt at source if that's possible
(or at destination in worst case).  The triggers have a reenable that
is then called only once all downstream consumers have handled a trigger
- that is used to then unmask the interrupt at source.  Here the challenge
is that overlaps with reading the register.  We tend to cheat a bit when
this happens and either not have a reenable callback or have one that
reads the register again (to support other consumers of this trigger if
this device isn't consuming it's own trigger).

An Ack before reading the data back isn't ideal but it may be the best
approach for this particular case.

> 
> In case this fix turns out to be not adequate, and no-one has a better one,
> then I'd propose to revert the level-triggered interrupt support (and maybe
> make the probe failing whenever an unsupported IRQ type is requested?).
> 
> [0] Here I'm on a custom board with a Zynq7000 SoC (IRQ controller supports
> both raising-edge and level IRQ) and an MPU9250 IMU. I've done most work on
> a 5.15 customized kernel, but I've tried also with latest mainline tree and
> I got the same results.
> 
> [1]  when running:
> 
> root@arm:/sys/bus/iio/devices/iio:device2/buffer0# echo 1 > enable ; sleep 5; echo 0 > enable
> 
> on a 5.15 kernel the system somehow survived, despite Oopses and
> complaints, so I could give a look to /proc/interrupts:
> 
> 64:    1119991          0     GIC-0  68 Level     inv_mpu
> 65:         55          0  mpu9250-dev2     Edge      mpu9250_consumer2
> 
> The hardware IRQ counted an unreasonably huge number of interrupts, while
> the trigger softirq counted a reasonable number of interrupts.
> 
> (On a working system i.e. before the blamed commit, or after my patch,
> these two counters count the same number of IRQs)
> 
> [2] Depending by a number of factors (e.g. RT-patch, kernel debug
> configuration options, kernel version) I got some different complaints. The
> following is the one I grabbed from the latest git tree kernel.
> (irq/47-41620000/45 refers to the I2C controller to witch the IMU is
> attached to):
> 
> [  250.941155] sched: RT throttling activated
> 
> [  275.557147] rcu: INFO: rcu_sched self-detected stall on CPU
> [  275.562749] rcu:     0-....: (26689 ticks this GP) idle=89dc/1/0x40000002 softirq=20591/20592 fqs=6234
> [  275.563143]
> [  275.563148] =============================
> [  275.563152] [ BUG: Invalid wait context ]
> [  275.563156] 6.5.0-rc3+ #17 Not tainted
> [  275.563163] -----------------------------
> [  275.563166] irq/47-41620000/45 is trying to lock:
> [  275.563173] c20ff850 (&port_lock_key){-.-.}-{3:3}, at: cdns_uart_console_write+0x130/0x164
> [  275.563226] other info that might help us debug this:
> [  275.563230] context-{3:3}
> [  275.563235] 4 locks held by irq/47-41620000/45:
> [  275.563242]  #0: c147d510 (rcu_node_0){-.-.}-{2:2}, at: rcu_sched_clock_irq+0x87c/0x12f0
> [  275.563285]  #1: c1416b30 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x100/0x320
> [  275.563327]  #2: c1416b98 (console_srcu){....}-{0:0}, at: console_flush_all+0x68/0x664
> [  275.563361]  #3: c1416c24 (console_owner){-.-.}-{0:0}, at: console_flush_all+0x1c4/0x664
> [  275.563395] stack backtrace:
> [  275.563399] CPU: 0 PID: 45 Comm: irq/47-41620000 Not tainted 6.5.0-rc3+ #17
> [  275.563412] Hardware name: Xilinx Zynq Platform
> [  275.563420]  unwind_backtrace from show_stack+0x10/0x14
> [  275.563450]  show_stack from dump_stack_lvl+0x68/0x90
> [  275.563474]  dump_stack_lvl from __lock_acquire+0x61c/0x1778
> [  275.563494]  __lock_acquire from lock_acquire+0x1e4/0x368
> [  275.563512]  lock_acquire from _raw_spin_lock_irqsave+0x54/0x68
> [  275.563534]  _raw_spin_lock_irqsave from cdns_uart_console_write+0x130/0x164
> [  275.563564]  cdns_uart_console_write from console_flush_all+0x220/0x664
> [  275.563595]  console_flush_all from console_unlock+0x88/0xd4
> [  275.563624]  console_unlock from vprintk_emit+0x25c/0x320
> [  275.563653]  vprintk_emit from vprintk_default+0x20/0x28
> [  275.563682]  vprintk_default from _printk+0x30/0x54
> [  275.563715]  _printk from print_cpu_stall_info+0x2b0/0x490
> [  275.563742]  print_cpu_stall_info from rcu_sched_clock_irq+0x890/0x12f0
> [  275.563766]  rcu_sched_clock_irq from update_process_times+0x54/0x8c
> [  275.563793]  update_process_times from tick_sched_timer+0x50/0xac
> [  275.563825]  tick_sched_timer from __hrtimer_run_queues+0x2f0/0x598
> [  275.563851]  __hrtimer_run_queues from hrtimer_interrupt+0x130/0x2ac
> [  275.563873]  hrtimer_interrupt from twd_handler+0x30/0x38
> [  275.563897]  twd_handler from handle_percpu_devid_irq+0xb0/0x2b4
> [  275.563928]  handle_percpu_devid_irq from generic_handle_domain_irq+0x24/0x34
> [  275.563950]  generic_handle_domain_irq from gic_handle_irq+0x84/0xac
> [  275.563981]  gic_handle_irq from generic_handle_arch_irq+0x34/0x44
> [  275.564009]  generic_handle_arch_irq from call_with_stack+0x18/0x20
> [  275.564032]  call_with_stack from __irq_svc+0x9c/0xb8
> [  275.564048] Exception stack(0xf0935e48 to 0xf0935e90)
> [  275.564062] 5e40:                   ffffffff ffffffff 00000001 00000403 ef7cb080 00000000
> [  275.564074] 5e60: c1be107c c4b01040 d1377d58 2e465000 c0d4b0d8 f0935ed4 00000000 f0935e98
> [  275.564082] 5e80: c015a054 c015a058 600f0013 ffffffff
> [  275.564089]  __irq_svc from finish_task_switch+0xe4/0x2b4
> [  275.564119]  finish_task_switch from __schedule+0x394/0xd9c
> [  275.564149]  __schedule from schedule+0x60/0xbc
> [  275.564176]  schedule from irq_thread+0xd0/0x238
> [  275.564201]  irq_thread from kthread+0xf4/0x12c
> [  275.564231]  kthread from ret_from_fork+0x14/0x28
> [  275.564251] Exception stack(0xf0935fb0 to 0xf0935ff8)
> [  275.564261] 5fa0:                                     00000000 00000000 00000000 00000000
> [  275.564271] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [  275.564280] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [  275.886419] rcu:              hardirqs   softirqs   csw/system
> [  275.891989] rcu:      number:  2641898          0            0
> [  275.897561] rcu:     cputime:        0          0        12997   ==> 13007(ms)
> [  275.904523] rcu:     (t=26010 jiffies g=36053 q=115 ncpus=2)
> [  275.909924] CPU: 0 PID: 45 Comm: irq/47-41620000 Not tainted 6.5.0-rc3+ #17
> [  275.916891] Hardware name: Xilinx Zynq Platform
> [  275.921413] PC is at finish_task_switch+0xe4/0x2b4
> [  275.926213] LR is at finish_task_switch+0xe0/0x2b4
> [  275.931013] pc : [<c015a058>]    lr : [<c015a054>]    psr: 600f0013
> [  275.937280] sp : f0935e98  ip : 00000000  fp : f0935ed4
> [  275.942505] r10: c0d4b0d8  r9 : 2e465000  r8 : d1377d58
> [  275.947722] r7 : c4b01040  r6 : c1be107c  r5 : 00000000  r4 : ef7cb080
> [  275.954249] r3 : 00000403  r2 : 00000001  r1 : ffffffff  r0 : ffffffff
> [  275.960777] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [  275.967914] Control: 18c5387d  Table: 04b8404a  DAC: 00000051
> [  275.973661]  finish_task_switch from __schedule+0x394/0xd9c
> [  275.979258]  __schedule from schedule+0x60/0xbc
> [  275.983806]  schedule from irq_thread+0xd0/0x238
> [  275.988442]  irq_thread from kthread+0xf4/0x12c
> [  275.992990]  kthread from ret_from_fork+0x14/0x28
> [  275.997702] Exception stack(0xf0935fb0 to 0xf0935ff8)
> [  276.002757] 5fa0:                                     00000000 00000000 00000000 00000000
> [  276.010936] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [  276.019110] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> [3] Previously, even if the DT node configured the IRQ as level-triggered,
> the MPU9060 driver changed it to edge-triggered, because it was the only
> supported mode. This made things working in my case. Now with the very same
> DT the IRQ is configured as level (which in principle should be correct)
> but things stopped working indeed.
> 

We will want to prune that description down a lot for any patch going upstream.
Just keep the relevant parts to actually spotting the problem which I think is
mostly a comment on there being far too many interrupts and rcu errors due
to that storm.

> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 11 -------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 31 ++++++++++++++++---
>  2 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 45c37525c2f1..b87ca50dc1c1 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -122,21 +122,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	int result;
>  	u16 fifo_count;
>  	s64 timestamp;
> -	int int_status;
>  	size_t i, nb;
>  
>  	mutex_lock(&st->lock);
>  
> -	/* ack interrupt and check status */
> -	result = regmap_read(st->map, st->reg->int_status, &int_status);
> -	if (result) {
> -		dev_err(regmap_get_device(st->map),
> -			"failed to ack interrupt\n");
> -		goto flush_fifo;
> -	}
> -	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))
> -		goto end_session;
> -
>  	if (!(st->chip_config.accl_fifo_enable |
>  		st->chip_config.gyro_fifo_enable |
>  		st->chip_config.magn_fifo_enable))
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 882546897255..b1384d729ced 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -217,6 +217,26 @@ static const struct iio_trigger_ops inv_mpu_trigger_ops = {
>  	.set_trigger_state = &inv_mpu_data_rdy_trigger_set_state,
>  };
>  
> +irqreturn_t inv_mpu6050_trigger_irq(int irq, void *private)
> +{
> +	struct inv_mpu6050_state *st = private;
> +
> +	iio_trigger_generic_data_rdy_poll(irq, st->trig);
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +irqreturn_t inv_mpu6050_trigger_thread_fn(int irq, void *private)
> +{
> +	struct inv_mpu6050_state *st = private;
> +	int int_status;
> +
> +	mutex_lock(&st->lock);
> +	regmap_read(st->map, st->reg->int_status, &int_status);

Why do you need the lock?  

It would be fine to cache the content of the register in st so
that the pollfunc triggered handler can see what was there.
*sigh* - why do people think read to clear is a sensible hardware design.
It saves an access cycle, but makes software messy.

As you say, that may not be necessary if there are other paths to cheaply
check if there should have been an interrupt.

General approach looks fine to me - but I would like inputs from
others more familiar with this device than I am.

> +	mutex_unlock(&st->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
>  {
>  	int ret;
> @@ -229,11 +249,12 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
>  	if (!st->trig)
>  		return -ENOMEM;
>  
> -	ret = devm_request_irq(&indio_dev->dev, st->irq,
> -			       &iio_trigger_generic_data_rdy_poll,
> -			       irq_type,
> -			       "inv_mpu",
> -			       st->trig);
> +	ret = devm_request_threaded_irq(&indio_dev->dev, st->irq,
> +					&inv_mpu6050_trigger_irq,
> +					&inv_mpu6050_trigger_thread_fn,
> +					irq_type | IRQF_ONESHOT,
> +					"inv_mpu",
> +					st);
>  	if (ret)
>  		return ret;
>  

