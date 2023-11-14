Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBAA7EAFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjKNMMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjKNMMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:12:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9144013A;
        Tue, 14 Nov 2023 04:12:45 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE9m9i6004924;
        Tue, 14 Nov 2023 12:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0SfVipAVrUFijpljgT0pTKxCt3707jWT/A+njdwlgqE=;
 b=QCjqoUzeJF8KX4McHduZ9ovtEoCX6s2o7wZmKv0bnFGwAQdNj4BUWzU11sfZ6UtbSCz9
 sS6JlzkxPtlPdKDKKx3WkE/btBAyvY2CIYu4kiw62mOm0XK+6zuZd1xiSlyaabl+YL0c
 0o8lhJ42Yhn4eQ/JL5sYQ/AWQamKFKTR31RqFymDj9sUncqnflAGLD+gT83aQHFWg3cJ
 ealLDRXzfYUTSDDE3QV0y9XBERR5ivrCUFAsorh+tjfpGDW89zTxI9uXcxPK6eqb7YGe
 EnK33m6WC+p1QDDkgvWzaES5fw2HIYpVYHZTSgD2KLcPxIhtv1fmlMIV8kmNVHPxb8EA +w== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubw6hhbt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 12:12:36 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AECCZ2a002994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 12:12:35 GMT
Received: from [10.216.63.64] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 14 Nov
 2023 04:12:32 -0800
Message-ID: <fe8f6f37-2534-6481-cc34-e561b3b7a510@quicinc.com>
Date:   Tue, 14 Nov 2023 17:42:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Performance: devfreq: avoid devfreq delay work re-init
 before
Content-Language: en-US
To:     huangzaiyang <huangzaiyang@oppo.com>, <myungjoo.ham@samsung.com>,
        <kyungmin.park@samsung.com>, <cw00.choi@samsung.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        huangzaiyang <joyyoung.wang@gmail.com>
References: <20231110093457.458-1-huangzaiyang@oppo.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231110093457.458-1-huangzaiyang@oppo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eAC_xr5kCKIQtBtwhSAPOA1brCJHfep5
X-Proofpoint-GUID: eAC_xr5kCKIQtBtwhSAPOA1brCJHfep5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_11,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140094
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2023 3:04 PM, huangzaiyang wrote:
> From: huangzaiyang <joyyoung.wang@gmail.com>
> 
> There is a timer_list race condition when executing the following test shell script:
> '''
> while true
> do
>          echo "simple_ondemand" > /sys/class/devfreq/1d84000.ufshc/governor
>          echo "performance" > /sys/class/devfreq/1d84000.ufshc/governor
> done
> '''
> 
> [13511.214366][    C3] Unable to handle kernel paging request at virtual address dead00000000012a
> [13511.214393][    C3] Mem abort info:
> [13511.214398][    C3]   ESR = 0x96000044
> [13511.214404][    C3]   EC = 0x25: DABT (current EL), IL = 32 bits
> [13511.214409][    C3]   SET = 0, FnV = 0
> [13511.214414][    C3]   EA = 0, S1PTW = 0
> [13511.214417][    C3] Data abort info:
> [13511.214422][    C3]   ISV = 0, ISS = 0x00000044
> [13511.214427][    C3]   CM = 0, WnR = 1
> [13511.214432][    C3] [dead00000000012a] address between user and kernel address ranges
> [13511.214439][    C3] Internal error: Oops: 96000044 [#1] PREEMPT SMP
> [13511.215449][    C3] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G S      W  O      5.10.168-android12-9-o-g63cc297a7b34 #1
> [13511.215454][    C3] Hardware name: Qualcomm Technologies, Inc. Cape MTP, Whiteswan (DT)
> [13511.215460][    C3] pstate: 82400085 (Nzcv daIf +PAN -UAO +TCO BTYPE=--)
> [13511.215472][    C3] pc : expire_timers+0x9c/0x428
> [13511.215478][    C3] lr : __run_timers+0x1f0/0x328
> [13511.215483][    C3] sp : ffffffc00801bdd0
> [13511.215487][    C3] x29: ffffffc00801bdf0 x28: ffffffdb87b31698
> [13511.215493][    C3] x27: ffffffdb87999e58 x26: ffffffdb87966008
> [13511.215499][    C3] x25: 0000000000000001 x24: ffffff8001734a00
> [13511.215506][    C3] x23: 00000000000000e0 x22: dead000000000122
> [13511.215512][    C3] x21: 000000010032658e x20: ffffff89f7a9ae80
> [13511.215518][    C3] x19: ffffffc00801be50 x18: ffffffc00801d038
> [13511.215525][    C3] x17: 0000000000000240 x16: 0000000000000201
> [13511.215532][    C3] x15: ffffffffffffffff x14: ffffff89f7a9aef8
> [13511.215538][    C3] x13: 0000000000000240 x12: ffffff89f7a9aea8
> [13511.215544][    C3] x11: 0000000000000021 x10: 000000014032658e
> [13511.215550][    C3] x9 : ffffffc00801be50 x8 : dead000000000122
> [13511.215556][    C3] x7 : ffff71646c68735e x6 : ffffff89f7aaae58
> [13511.215563][    C3] x5 : 0000000000000000 x4 : 0000000000000101
> [13511.215569][    C3] x3 : ffffff89f7a9aef0 x2 : ffffff89f7a9aef0
> [13511.215575][    C3] x1 : ffffffc00801be50 x0 : ffffff8045804428
> [13511.215581][    C3] Call trace:
> [13511.215586][    C3]  expire_timers+0x9c/0x428
> [13511.215591][    C3]  __run_timers+0x1f0/0x328
> [13511.215596][    C3]  run_timer_softirq+0x28/0x58
> [13511.215602][    C3]  efi_header_end+0x168/0x5ec
> [13511.215610][    C3]  __irq_exit_rcu+0x108/0x124
> [13511.215617][    C3]  __handle_domain_irq+0x118/0x1e4
> [13511.215625][    C3]  gic_handle_irq.31230+0x6c/0x250
> [13511.215630][    C3]  el1_irq+0xe4/0x1c0
> [13511.215638][    C3]  cpuidle_enter_state+0x3a4/0xa04
> [13511.215644][    C3]  do_idle+0x308/0x574
> [13511.215649][    C3]  cpu_startup_entry+0x84/0x90
> [13511.215656][    C3]  secondary_start_kernel+0x204/0x274
> [13511.215664][    C3] Code: d503201f a9402408 f9000128 b4000048 (f9000509)
> [13511.215670][    C3] ---[ end trace 5100bad72a35d566 ]---
> [13511.215676][    C3] Kernel panic - not syncing: Oops: Fatal exception in interrupt
> 
> This is because when switching the governor through the sys node,
> the devfreq_monitor_start function will re-initialize the delayed work task,
> which will cause the delay work pending flag to become invalid, and the timer pending judgment contained in the delayed work will also become invalid,
> and then the pending interception will be executed when the queue is executed.
> 
> So we remove the delay work'initialization work to the devfreq_add_device and timer_store functions,
> and the delay work pending judgment is performed before the devfreq_monitor_start function performs the queue operation.
> 
> Signed-off-by: ZaiYang Huang <huangzaiyang@oppo.com>
> ---
>   drivers/devfreq/devfreq.c | 36 ++++++++++++++++++++++++------------
>   1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index b3a68d5833bd..8ae6f853a21e 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -483,18 +483,7 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>          if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
>                  return;
> 
> -       switch (devfreq->profile->timer) {
> -       case DEVFREQ_TIMER_DEFERRABLE:
> -               INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> -               break;
> -       case DEVFREQ_TIMER_DELAYED:
> -               INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
> -               break;
> -       default:
> -               return;
> -       }
> -
> -       if (devfreq->profile->polling_ms)
> +       if (devfreq->profile->polling_ms && !delayed_work_pending(&devfreq->work))
>                  queue_delayed_work(devfreq_wq, &devfreq->work,
>                          msecs_to_jiffies(devfreq->profile->polling_ms));
>   }
> @@ -830,6 +819,17 @@ struct devfreq *devfreq_add_device(struct device *dev,
>                  goto err_dev;
>          }
> 
> +       switch (devfreq->profile->timer) {
> +       case DEVFREQ_TIMER_DEFERRABLE:
> +               INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> +               break;
> +       case DEVFREQ_TIMER_DELAYED:
> +               INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
> +               break;
> +       default:
> +               dev_err(dev, "%s: Target devfreq(%s)'s profile timer has no settings \n", devfreq->governor_name,
> +                       __func__);
> +       }

[..]

>          if (!devfreq->profile->max_state || !devfreq->profile->freq_table) {
>                  mutex_unlock(&devfreq->lock);
>                  err = set_freq_table(devfreq);
> @@ -1860,6 +1860,18 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
>          df->profile->timer = timer;
>          mutex_unlock(&df->lock);
> 
> +       switch (df->profile->timer) {
> +       case DEVFREQ_TIMER_DEFERRABLE:
> +               INIT_DEFERRABLE_WORK(&df->work, devfreq_monitor);
> +               break;
> +       case DEVFREQ_TIMER_DELAYED:
> +               INIT_DELAYED_WORK(&df->work, devfreq_monitor);
> +               break;
> +       default:
> +               dev_err(dev, "%s: Target devfreq(%s)'s profile timer has no settings \n", df->governor_name,
> +                       __func__);
> +       }
> +
Here, this can cause issue right, as it is modifying the delayed work
data even before stopping the current running instances..

Should the above thing be done after DEVFREQ_GOV_STOP ?
But again it will boil down to the same thing as it is currently
now .
>          ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
>          if (ret) {
>                  dev_warn(dev, "%s: Governor %s not stopped(%d)\n",

I was thinking if i put mutex around cancel_delayed_work_sync() as well 
in devfreq_monitor_stop() on top of below patch, should cover the 
corruption of workdata.

https://lore.kernel.org/all/1699957648-31299-1-git-send-email-quic_mojha@quicinc.com/

-Mukesh

> --
> 2.17.1

Remove the entire below thing..>
> ________________________________
> OPPO
> 
> ±¾µç×ÓÓÊ¼þ¼°Æä¸½¼þº¬ÓÐOPPO¹«Ë¾µÄ±£ÃÜÐÅÏ¢£¬½öÏÞÓÚÓÊ¼þÖ¸Ã÷µÄÊÕ¼þÈË£¨°üº¬¸öÈË¼°Èº×é£©Ê¹ÓÃ¡£½ûÖ¹ÈÎºÎÈËÔÚÎ´¾­ÊÚÈ¨µÄÇé¿öÏÂÒÔÈÎºÎÐÎÊ½Ê¹ÓÃ¡£Èç¹ûÄú´íÊÕÁË±¾ÓÊ¼þ£¬ÇÐÎð´«²¥¡¢·Ö·¢¡¢¸´ÖÆ¡¢Ó¡Ë¢»òÊ¹ÓÃ±¾ÓÊ¼þÖ®ÈÎºÎ²¿·Ö»òÆäËùÔØÖ®ÈÎºÎÄÚÈÝ£¬²¢ÇëÁ¢¼´ÒÔµç×ÓÓÊ¼þÍ¨Öª·¢¼þÈË²¢É¾³ý±¾ÓÊ¼þ¼°Æä¸½¼þ¡£
> ÍøÂçÍ¨Ñ¶¹ÌÓÐÈ±ÏÝ¿ÉÄÜµ¼ÖÂÓÊ¼þ±»½ØÁô¡¢ÐÞ¸Ä¡¢¶ªÊ§¡¢ÆÆ»µ»ò°üº¬¼ÆËã»ú²¡¶¾µÈ²»°²È«Çé¿ö£¬OPPO¶Ô´ËÀà´íÎó»òÒÅÂ©¶øÒýÖÂÖ®ÈÎºÎËðÊ§¸Å²»³Ðµ£ÔðÈÎ²¢±£ÁôÓë±¾ÓÊ¼þÏà¹ØÖ®Ò»ÇÐÈ¨Àû¡£
> ³ý·ÇÃ÷È·ËµÃ÷£¬±¾ÓÊ¼þ¼°Æä¸½¼þÎÞÒâ×÷ÎªÔÚÈÎºÎ¹ú¼Ò»òµØÇøÖ®ÒªÔ¼¡¢ÕÐÀ¿»ò³ÐÅµ£¬ÒàÎÞÒâ×÷ÎªÈÎºÎ½»Ò×»òºÏÍ¬Ö®ÕýÊ½È·ÈÏ¡£ ·¢¼þÈË¡¢ÆäËùÊô»ú¹¹»òËùÊô»ú¹¹Ö®¹ØÁª»ú¹¹»òÈÎºÎÉÏÊö»ú¹¹Ö®¹É¶«¡¢¶­ÊÂ¡¢¸ß¼¶¹ÜÀíÈËÔ±¡¢Ô±¹¤»òÆäËûÈÎºÎÈË£¨ÒÔÏÂ³Æ¡°·¢¼þÈË¡±»ò¡°OPPO¡±£©²»Òò±¾ÓÊ¼þÖ®ÎóËÍ¶ø·ÅÆúÆäËùÏíÖ®ÈÎºÎÈ¨Àû£¬Òà²»¶ÔÒò¹ÊÒâ»ò¹ýÊ§Ê¹ÓÃ¸ÃµÈÐÅÏ¢¶øÒý·¢»ò¿ÉÄÜÒý·¢µÄËðÊ§³Ðµ£ÈÎºÎÔðÈÎ¡£
> ÎÄ»¯²îÒìÅûÂ¶£ºÒòÈ«ÇòÎÄ»¯²îÒìÓ°Ïì£¬µ¥´¿ÒÔYES\OK»òÆäËû¼òµ¥´Ê»ãµÄ»Ø¸´²¢²»¹¹³É·¢¼þÈË¶ÔÈÎºÎ½»Ò×»òºÏÍ¬Ö®ÕýÊ½È·ÈÏ»ò½ÓÊÜ£¬ÇëÓë·¢¼þÈËÔÙ´ÎÈ·ÈÏÒÔ»ñµÃÃ÷È·ÊéÃæÒâ¼û¡£·¢¼þÈË²»¶ÔÈÎºÎÊÜÎÄ»¯²îÒìÓ°Ïì¶øµ¼ÖÂ¹ÊÒâ»ò´íÎóÊ¹ÓÃ¸ÃµÈÐÅÏ¢ËùÔì³ÉµÄÈÎºÎÖ±½Ó»ò¼ä½ÓËðº¦³Ðµ£ÔðÈÎ¡£
> This e-mail and its attachments contain confidential information from OPPO, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you are not the intended recipient, please do not read, copy, distribute, or use this information. If you have received this transmission in error, please notify the sender immediately by reply e-mail and then delete this message.
> Electronic communications may contain computer viruses or other defects inherently, may not be accurately and/or timely transmitted to other systems, or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall not be liable for any damages that arise or may arise from such matter and reserves all rights in connection with the email.
> Unless expressly stated, this e-mail and its attachments are provided without any warranty, acceptance or promise of any kind in any country or region, nor constitute a formal confirmation or acceptance of any transaction or contract. The sender, together with its affiliates or any shareholder, director, officer, employee or any other person of any such institution (hereinafter referred to as "sender" or "OPPO") does not waive any rights and shall not be liable for any damages that arise or may arise from the intentional or negligent use of such information.
> Cultural Differences Disclosure: Due to global cultural differences, any reply with only YES\OK or other simple words does not constitute any confirmation or acceptance of any transaction or contract, please confirm with the sender again to ensure clear opinion in written form. The sender shall not be responsible for any direct or indirect damages resulting from the intentional or misuse of such information.
> ________________________________
> OPPO
> 
> 本电子邮件及其附件含有OPPO公司的保密信息，仅限于邮件指明的收件人（包含个人及群组）使用。禁止任何人在未经授权的情况下以任何形式使用。如果您错收了本邮件，切勿传播、分发、复制、印刷或使用本邮件之任何部分或其所载之任何内容，并请立即以电子邮件通知发件人并删除本邮件及其附件。
> 网络通讯固有缺陷可能导致邮件被截留、修改、丢失、破坏或包含计算机病毒等不安全情况，OPPO对此类错误或遗漏而引致之任何损失概不承担责任并保留与本邮件相关之一切权利。
> 除非明确说明，本邮件及其附件无意作为在任何国家或地区之要约、招揽或承诺，亦无意作为任何交易或合同之正式确认。 发件人、其所属机构或所属机构之关联机构或任何上述机构之股东、董事、高级管理人员、员工或其他任何人（以下称“发件人”或“OPPO”）不因本邮件之误送而放弃其所享之任何权利，亦不对因故意或过失使用该等信息而引发或可能引发的损失承担任何责任。
> 文化差异披露：因全球文化差异影响，单纯以YES\OK或其他简单词汇的回复并不构成发件人对任何交易或合同之正式确认或接受，请与发件人再次确认以获得明确书面意见。发件人不对任何受文化差异影响而导致故意或错误使用该等信息所造成的任何直接或间接损害承担责任。
> This e-mail and its attachments contain confidential information from OPPO, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you are not the intended recipient, please do not read, copy, distribute, or use this information. If you have received this transmission in error, please notify the sender immediately by reply e-mail and then delete this message.
> Electronic communications may contain computer viruses or other defects inherently, may not be accurately and/or timely transmitted to other systems, or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall not be liable for any damages that arise or may arise from such matter and reserves all rights in connection with the email.
> Unless expressly stated, this e-mail and its attachments are provided without any warranty, acceptance or promise of any kind in any country or region, nor constitute a formal confirmation or acceptance of any transaction or contract. The sender, together with its affiliates or any shareholder, director, officer, employee or any other person of any such institution (hereinafter referred to as "sender" or "OPPO") does not waive any rights and shall not be liable for any damages that arise or may arise from the intentional or negligent use of such information.
> Cultural Differences Disclosure: Due to global cultural differences, any reply with only YES\OK or other simple words does not constitute any confirmation or acceptance of any transaction or contract, please confirm with the sender again to ensure clear opinion in written form. The sender shall not be responsible for any direct or indirect damages resulting from the intentional or misuse of such information.
