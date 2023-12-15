Return-Path: <linux-kernel+bounces-340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FD6813FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14CA283FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C1CA48;
	Fri, 15 Dec 2023 02:24:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E57FC;
	Fri, 15 Dec 2023 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5f9506ed13284b069b9c8d4c3b12dcb9-20231215
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:6ba37212-3642-47fd-9174-d574b1e86a4f,IP:25,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:28,RULE:Release_Ham,ACT
	ION:release,TS:38
X-CID-INFO: VERSION:1.1.33,REQID:6ba37212-3642-47fd-9174-d574b1e86a4f,IP:25,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
	N:release,TS:38
X-CID-META: VersionHash:364b77b,CLOUDID:717a32bd-2ac7-4da2-9f94-677a477649d9,B
	ulkID:231212231719IH1VMLZ5,BulkQuantity:31,Recheck:0,SF:64|66|38|24|17|19|
	44|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:40|20,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
	TF_CID_SPAM_FSI,TF_CID_SPAM_OBB,TF_CID_SPAM_FCD
X-UUID: 5f9506ed13284b069b9c8d4c3b12dcb9-20231215
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1143155449; Fri, 15 Dec 2023 10:18:59 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id B892B16001CD6;
	Fri, 15 Dec 2023 10:18:58 +0800 (CST)
X-ns-mid: postfix-657BB792-606681329
Received: from [172.20.116.203] (unknown [172.20.116.203])
	by node4.com.cn (NSMail) with ESMTPA id 6E1F516001CD6;
	Fri, 15 Dec 2023 02:18:56 +0000 (UTC)
Message-ID: <a6db4a82-3d04-47c0-8f29-0e2e5932face@kylinos.cn>
Date: Fri, 15 Dec 2023 10:18:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irq: Resolve that mask_irq/unmask_irq may not be called
 in pairs
Content-Language: en-US
To: Andy Shevchenko <andy@kernel.org>, Serge Semin <fancer.lancer@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com,
 linux-input@vger.kernel.org, stable@vger.kernel.org,
 Riwen Lu <luriwen@kylinos.cn>, hoan@os.amperecomputing.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231207014003.12919-1-xiongxin@kylinos.cn> <87ttosssxd.ffs@tglx>
 <e125491c-4cdb-4870-924a-baeb7453bf78@kylinos.cn> <874jgnqwlo.ffs@tglx>
 <bf4004bf-4868-4953-8d8e-0c0e03be673e@kylinos.cn> <875y12p2r0.ffs@tglx>
 <1844c927-2dd4-49b4-a6c4-c4c176b1f75d@kylinos.cn>
 <f5vtfoqylht5ijj6tdvxee3f3u6ywps2it7kv3fhmfsx75od2y@ftjlt4t4z4dk>
 <ZXspNGWszB9jAown@smile.fi.intel.com>
From: xiongxin <xiongxin@kylinos.cn>
In-Reply-To: <ZXspNGWszB9jAown@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2023/12/15 00:11, Andy Shevchenko =E5=86=99=E9=81=93:
> On Thu, Dec 14, 2023 at 01:06:23PM +0300, Serge Semin wrote:
>> On Thu, Dec 14, 2023 at 09:54:06AM +0800, xiongxin wrote:
>>> =E5=9C=A8 2023/12/13 22:59, Thomas Gleixner =E5=86=99=E9=81=93:
>>>> On Wed, Dec 13 2023 at 10:29, xiongxin wrote:
>>>>> =E5=9C=A8 2023/12/12 23:17, Thomas Gleixner =E5=86=99=E9=81=93:
>>>>> Sorry, the previous reply may not have clarified the BUG process. I
>>>>> re-debugged and confirmed it yesterday. The current BUG execution
>>>>> sequence is described as follows:
>>>>
>>>> It's the sequence how this works and it works correctly.
>>>>
>>>> Just because it does not work on your machine it does not mean that =
this
>>>> is incorrect and a BUG.
>>>>
>>>> You are trying to fix a symptom and thereby violating guarantees of =
the
>>>> core code.
>>>>
>>>>> That is, there is a time between the 1:handle_level_irq() and
>>>>> 3:irq_thread_fn() calls for the 2:disable_irq() call to acquire the=
 lock
>>>>> and then implement the irq_state_set_disabled() operation. When fin=
ally
>>>>> call irq_thread_fn()->irq_finalize_oneshot(), it cannot enter the
>>>>> unmask_thread_irq() process.
>>>>
>>>> Correct, because the interrupt has been DISABLED in the mean time.
>>>>
>>>>> In this case, the gpio irq_chip irq_mask()/irq_unmask() callback pa=
irs
>>>>> are not called in pairs, so I think this is a BUG, but not necessar=
ily
>>>>> fixed from the irq core code layer.
>>>>
>>>> No. It is _NOT_ a BUG. unmask() is not allowed to be invoked when th=
e
>>>> interrupt is DISABLED. That's the last time I'm going to tell you th=
at.
>>>> Only enable_irq() can undo the effect of disable_irq(), period.
>>>>
>>>>> Next, when the gpio controller driver calls the suspend/resume proc=
ess,
>>>>> it is as follows:
>>>>>
>>>>> suspend process:
>>>>> dwapb_gpio_suspend()
>>>>>        ctx->int_mask   =3D dwapb_read(gpio, GPIO_INTMASK);
>>>>>
>>>>> resume process:
>>>>> dwapb_gpio_resume()
>>>>>        dwapb_write(gpio, GPIO_INTMASK, ctx->int_mask);
>>>>
>>>> Did you actually look at the sequence I gave you?
>>>>
>>>>      Suspend:
>>>>
>>>> 	  i2c_hid_core_suspend()
>>>> 	     disable_irq();       <- Marks it disabled and eventually
>>>> 				     masks it.
>>>>
>>>> 	  gpio_irq_suspend()
>>>> 	     save_registers();    <- Saves masked interrupt
>>>>
>>>>      Resume:
>>>>
>>>> 	  gpio_irq_resume()
>>>> 	     restore_registers(); <- Restores masked interrupt
>>>>
>>>> 	  i2c_hid_core_resume()
>>>> 	     enable_irq();        <- Unmasks interrupt and removes the
>>>> 				     disabled marker
>>>>
>>>>
>>>> Have you verified that this order of invocations is what happens on
>>>> your machine?
>>>>
>>>> Thanks,
>>>>
>>>>           tglx
>>>
>>> As described earlier, in the current situation, the irq_mask() callba=
ck of
>>> gpio irq_chip is called in mask_irq(), followed by the disable_irq() =
in
>>> i2c_hid_core_suspend(), unmask_irq() will not be executed.
>>>
>>> Then call enable_irq() in i2c_hid_core_resume(). Since gpio irq_chip =
does
>>> not implement the irq_startup() callback, it ends up calling irq_enab=
le().
>>>
>>> The irq_enable() function is then implemented as follows:
>>>
>>> irq_state_clr_disabled(desc);
>>> if (desc->irq_data.chip->irq_enable) {
>>> 	desc->irq_data.chip->irq_enable(&desc->irq_data);
>>> 	irq_state_clr_masked(desc);
>>> } else {
>>> 	unmask_irq(desc);
>>> }
>>>
>>> Because gpio irq_chip implements irq_enable(), unmask_irq() is not ex=
ecuted,
>>> and gpio irq_chip's irq_unmask() callback is not called. Instead,
>>> irq_state_clr_masked() was called to clear the masked flag.
>>>
>>> The irq masked behavior is actually controlled by the
>>> irq_mask()/irq_unmask() callback function pairs in gpio irq_chip. Whe=
n the
>>> whole situation occurs, there is one more irq_mask() operation, or on=
e less
>>> irq_unmask() operation. This ends the i2c hid resume and the gpio
>>> corresponding i2c hid interrupt is also masked.
>>>
>>> Please help confirm whether the current situation is a BUG, or sugges=
t other
>>> solutions to fix it.
>>
>> I has just been Cc'ed to this thread from the very start of the thread
>> so not sure whether I fully understand the problem. But a while ago an
>> IRQ disable/undisable-mask/unmask-unpairing problem was reported for
>> DW APB GPIO driver implementation, but in a another context though:
>> https://lore.kernel.org/linux-gpio/1606728979-44259-1-git-send-email-l=
uojiaxing@huawei.com/
>> We didn't come to a final conclusion back then, so the patch got lost
>> in the emails archive. Xiong, is it related to the problem in your
>> case?
>=20
>  From what explained it sounds to me that GPIO driver has missing part =
and
> this seems the missing patch (in one or another form). Perhaps we can g=
et
> a second round of review,
>=20

Yes, the current case is exactly the situation described in the link,=20
and the specific implementation process is as described in my previous=20
email. After adding the patch for retest, the exception can be=20
effectively solved. And at present, can the patch be incorporated?

Thank you Thomas for your kind advice!

My previous focus has been locked until mask_irq()/unmask_irq() is not=20
called in pairs, in fact, it can turn on the corresponding irq masked in=20
enable_irq. Looking at the irq_enable() callback implementation of other=20
GPIO interrupt controllers, there are indeed operations on masked registe=
rs.

Thank you all!

