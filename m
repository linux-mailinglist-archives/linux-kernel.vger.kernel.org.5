Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829237DFAF8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377220AbjKBTgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBTgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:36:50 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F89E7;
        Thu,  2 Nov 2023 12:36:45 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1cc3542e328so10481785ad.1;
        Thu, 02 Nov 2023 12:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698953804; x=1699558604;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQJRwVGrqkbOP2rQwY3hByNiVCWEO2BBjk5kXR5X//4=;
        b=LqLR0rJ/SJ3xBOwmJn72SnZ7URVGlhRYkKjiAr7XuXxCIiwTWsKx3e5ZV8uROgNahP
         u8K5yBpsSI7awQYkTH5apY2MfcTYupfjKpk9hPb6+MXSJXskag6RzYvRWUbFiqKa42XZ
         iwCDlqQl+8QrBRR+JA3iS5T+FLeIs6ryxJBM+pID1tQx8CRZb5LzpvEbE5EHrxLpkpXn
         XnMF/73fM+0gFaLGDHmqQlFNoxND4JalCsvtmWOltlMxrPol6HqIPF7xYUpD5CZCU9Ex
         PwBpc/zgmEaCkaxN76SenhmZ/YqIQ66BLS0btXcjzTxWeIQOJqibp053AHl2wBNCxvaO
         b3xw==
X-Gm-Message-State: AOJu0YzcFJuFqrds17jmpAvcgZ/ZWecOvGNepK0+ucImsP4f9zbUBYDe
        mBHbEp5lqPi1RauPGGm1H2s=
X-Google-Smtp-Source: AGHT+IGjt64blOz6dYkFcgNGT6Gy9r9Ym92d/0DHW94dRcRKZ52hcLIAnVsSmS3Ndc+1YjqmClwLTw==
X-Received: by 2002:a17:902:8216:b0:1cc:15ec:3f53 with SMTP id x22-20020a170902821600b001cc15ec3f53mr15484618pln.36.1698953804483;
        Thu, 02 Nov 2023 12:36:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:87f7:9784:4475:1cd4? ([2620:15c:211:201:87f7:9784:4475:1cd4])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902ea8b00b001c5fa48b9a0sm102827plb.33.2023.11.02.12.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 12:36:43 -0700 (PDT)
Message-ID: <633b3970-ddd4-4dc6-b586-96ecc5b86456@acm.org>
Date:   Thu, 2 Nov 2023 12:36:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] scsi: ufs: core: Process abort completed command in
 MCQ mode
Content-Language: en-US
To:     hoyoung seo <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        kwangwon.min@samsung.com, kwmad.kim@samsung.com,
        sh425.lee@samsung.com, sc.suh@samsung.com,
        quic_nguyenb@quicinc.com, cpgs@samsung.com
References: <CGME20231101084246epcas2p32ae15219878d1c31e7d8a14c22489519@epcas2p3.samsung.com>
 <20231101084504.79087-1-hy50.seo@samsung.com>
 <e1ed8776-d8ad-49f2-bf8f-2759256e33e9@acm.org>
 <000001da0d42$1a1c8410$4e558c30$@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <000001da0d42$1a1c8410$4e558c30$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/1/23 21:07, hoyoung seo wrote:
> when the ufs host receives any error, the ufs driver executes the error-hander.
> If the error-hendler attempts re-init, it must abort and organize unprocessed
>   requests.
> The above operation is the same for both MCQ/legacy mode.
> However, in the MCQ mode, if b or c is included in the following specs,
> the OCS is updated to aborted, which is different from the legacy mode.
> 
> B. If the command is in the Submission Queue and not issued to the device yet,
> the host controller will mark the command to be skipped in the Submission Queue.
> The host controller will post to the Completion Queue to update the OCS field
> with ‘ABORTED’.
> C. If the command is issued to the device already but there is no response yet
> from the device, the host software driver issue the Abort task management function
>   to the device for that command.
> Then the host driver set SQRTCy.ICU as ‘1’ to initiate the clean up the hardware
> resources. The host controller will post to the Completion Queue to update the OCS
>   field with ‘ABORTED’.
> 
> Unlike legacy mode, this phenomenon causes unintended behavior. (As shown in the log below)
> 
> [1:  kworker/u20:2:23157] ufshcd_try_to_abort_task: cmd pending in the device. tag = 9
> [3:  kworker/u20:2:23157] Aborting tag 9 / CDB 0x2a succeeded
> [4:      swapper/4:    0] sd 0:0:0:0: [sda] tag#9 UNKNOWN(0x2003) Result: hostbyte=0x05 driverbyte=DRIVER_OK cmd_age=0s // DID_ABORT
> [4:      swapper/4:    0] sd 0:0:0:0: [sda] tag#9 CDB: opcode=0x2a 2a 00 00 d3 02 00 00 01 00 00
> [4:      swapper/4:    0] I/O error, dev sda, sector 110628864 op 0x1:(WRITE) flags 0x800 phys_seg 256 prio class 2
> 
> 
> For commands that have completed the abort operation in MCQ mode,
> since OCS has been updated to aborted, it seems that it will be retransmitted only
>   when it is made to REQUEUE.

Hi Hoyoung,

Thank you for having provided this clarification - this really helps.

Regarding (B): I would appreciate it if this patch would be reworked
such that no new 'if (is_mcq_enabled(hba))' statements are introduced.
Has it been considered to modify ufshcd_mcq_sqe_search() such that it
sets the SCSI result to DID_REQUEUE << 16 instead of modifying
ufshcd_transfer_rsp_status()?

Regarding (C): SQRTCy.ICU is only set by ufshcd_mcq_sq_cleanup() and the 
only caller of that function is ufshcd_clear_cmd().
There is only one function that calls ufshcd_clear_cmd() for SCSI
commands, namely ufshcd_eh_device_reset_handler(). The latter function
should not set the SCSI result code. All it should do is to abort all
pending commands. The SCSI error handler will resubmit all aborted commands.

Thanks,

Bart.
