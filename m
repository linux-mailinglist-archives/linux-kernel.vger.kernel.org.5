Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E507D1B81
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjJUHVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUHVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:21:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A6CD66;
        Sat, 21 Oct 2023 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697872859; x=1698477659; i=deller@gmx.de;
        bh=t0qmlBuPY/Ez7cc6cey9RvpwpcwJrhijO9qCda7KbxA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=BR5xTn6Q1t+sRGha0lXJwR760k81bRCESjW8XQCOsI2h3TABFQ5hlCFSYPLzL4n8
         8fw/ZzXB+w/Ppu+t+HWEKfLV0eRYbA0Jqi7oRHtpD/BrVkFhVtGZhTlsc/2iaUD7i
         e8qLgknBKcX2ASWK8uvKYV+cwD89xNPMhq3NSZ0VCMicOGcX0y3K+SMp1f7FIMsub
         Ai3Y+C23BSDs9N/MCPjK2zaihixL5oilSaR7PmN2yFAm990aakTfxi6GJZYqUMV7M
         JLRnTk/zX+zzO2qqpMpMPQivXxFTriS4JOgzMHw4g5Dvd6vGKuoEKtvs1jfBRToJj
         KdJLbTD1CW4UmxbqwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.149]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHQX-1rMW5y1awL-00kiyV; Sat, 21
 Oct 2023 09:20:59 +0200
Message-ID: <b25c8ea1-efcd-4861-a9b4-5db89ccc7070@gmx.de>
Date:   Sat, 21 Oct 2023 09:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: simplify smp_prepare_boot_cpu()
Content-Language: en-US
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        linux-parisc@vger.kernel.org
References: <E1qtqkk-00AJHA-1u@rmk-PC.armlinux.org.uk>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <E1qtqkk-00AJHA-1u@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gI/ncdJ0WG05ciTiNiPfvAmpR2yduFRb45bhhS/o8bbksVDM4vw
 7Cw1DWh+Dfeiooc20khtrM46pEx7Xp4Au+tZ/NQOLThqmATsxoyP6g6+Hgab1yzHTh1oTTw
 +A81acUIDgG7/08mKQaIHGfT2X3ekie0dxGgbwvY7O63fd1N7UGXhgV9r/+VvmEgey/SqeQ
 lpb+qkTuF1HEggHXcRCpQ==
UI-OutboundReport: notjunk:1;M01:P0:Yww/wBIHv+E=;w6hOY7IcprQJ9ea9gbUQwe8Io2t
 2O5KbX18Wq2gIZEAuOFgtNY+IRDByo0ti2Q9qaYC9UeBiB+lm4z390CzYe5bDu+3+ao+CfXf6
 SQ3w9r31TzDx6F4NwaKiwt4sTGT7ZgNDdX6y+EFmr71WBh9jpDQCPBogNA0zmMOZvTuT+9cqf
 okAkCIv0OeOdwkZi9iKD7zVlUZLXPWoZPMxnfJN8nm7MZjyITTy4TCC0YS9za176+dwmqf87d
 xheBFENGiquqgaVNxOPsLB4qmGUnVFdLc6GFUIYALmZyuI0Uq7H8T9OcR+vOPbx7PrWxQQcgg
 AU8Y1QrMJkIUkNcNUOGau2zaYj35V+A1rGFio04R2ueWA0cGrIMc4v4aufPAKtLnr6MutY7HK
 JPLc+RbUpbDyScw0DtQMzkgkZStS5GJTbNbL2C7lrs0GbP0S6VJp5Z6QHSjRuBCANWIjbKegk
 PuWfn47MCUqJ6X/AOyxMeMPAYlmlLrDW9hFGXX9D2H7k3kwBixDzQc6tfwVWx/8kEhCwgeoZf
 TIiYPK/osQvSfGzkF/Mles2MAOM1Egm1l+82f4goEfUBnZYAgR3cvmtDt4Ma8ZunXHHl72tOp
 WwRExVjv7F4E9G9U9kXiF5a60JK34mNfIEwM+xDZBATcHs23f69vSzkxzKrRidgajrelTVhQL
 QW6cED6GMW14DrdacbaznZD3eW0lP60B7tOcLCSMnzVSlMM8iN1bT/5+vdCxkGmqmX4BI01qe
 XlCPD7U4pktliskKv7nontz+Pm6943g4EOeJ9xrQ7A9YQ+iWt3XuOqHUv+wTw/EuCPbObTjcK
 SoeXqWBX9UquxcMwcfMXYl0hJV2mjXobp6gQOmMgrZ/2RzCcRtHFD2PZDCnrUeTJf8dM4PpwV
 PCb83sFh9iaxopDcj1y8HQZYrvJ/Vrc6uOyhkfSTXFOAqDRq/fSDWUG8wjLVy0ECKtaoFkIk9
 i1IWC9mkaNHQFhmq0559ZrVVXsM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/23 16:45, Russell King (Oracle) wrote:
> smp_prepare_boot_cpu() reads the cpuid of the first CPU, printing a
> message to state which processor booted, and setting it online and
> present.
>
> This cpuid is retrieved from per_cpu(cpu_data, 0).cpuid, which is
> initialised in arch/parisc/kernel/processor.c:processor_probe() thusly:
>
> 	p =3D &per_cpu(cpu_data, cpuid);
> ...
> 	p->cpuid =3D cpuid;	/* save CPU id */
>
> Consequently, the cpuid retrieved seems to be guaranteed to also be
> zero, meaning that the message printed in this boils down to:
>
> 	pr_info("SMP: bootstrap CPU ID is 0\n");
>
> Moreover, since kernel/cpu.c::boot_cpu_init() already sets CPU 0 to
> be present and online, there is no need to do this again in
> smp_prepare_boot_cpu().
>
> Remove this code, and simplify the printk().
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

applied.
Removed the "Setup BSP mappings" comment too, as
Jonathan Cameron suggested.

Thank you!
Helge




> ---
>   arch/parisc/kernel/smp.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
> index 2019c1f04bd0..989efc8c67a5 100644
> --- a/arch/parisc/kernel/smp.c
> +++ b/arch/parisc/kernel/smp.c
> @@ -404,13 +404,8 @@ static int smp_boot_one_cpu(int cpuid, struct task_=
struct *idle)
>
>   void __init smp_prepare_boot_cpu(void)
>   {
> -	int bootstrap_processor =3D per_cpu(cpu_data, 0).cpuid;
> -
>   	/* Setup BSP mappings */
> -	printk(KERN_INFO "SMP: bootstrap CPU ID is %d\n", bootstrap_processor)=
;
> -
> -	set_cpu_online(bootstrap_processor, true);
> -	set_cpu_present(bootstrap_processor, true);
> +	pr_info("SMP: bootstrap CPU ID is 0\n");
>   }
>
>

