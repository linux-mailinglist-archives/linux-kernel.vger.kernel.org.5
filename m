Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ECA7A877D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbjITOqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbjITOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:46:07 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1362E1996;
        Wed, 20 Sep 2023 07:38:55 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-68fb6fd2836so6351593b3a.0;
        Wed, 20 Sep 2023 07:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695220693; x=1695825493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsiOE3sViWDOZyKIgjf60eL0/VIA+MntKbdNkIr6/zE=;
        b=YBMUrBNZIEzJVDwkekCpedgTwFp7gRJEaLhPXeHbbfdsdRcx+idX7C6clA5KeZWIjC
         IoiwXWT77GXkLOOwnS/btwYX7ZpO4SWsl6EEvCrAKilpi/DiMzG47bYAMxHmDjmt9oJP
         hh2EN2MWYssqmFnCihwS5Ew+WbTdFwf7AwxWAOANnRnjsGOspNCMx6QFnZkhYdKpz4k9
         9ZsyzowsAHGdJLpREzfk4XBNdZSh83XK2kyW3ESpOhGN62GbJ4ftXBvlIjUezgRUAa41
         yL57A116jKxGUj9kjb/A8oqumtOAvX+pmPq2JWZtaiQu8fdV57bEe3ECU5+tn60Gb7cK
         BL2w==
X-Gm-Message-State: AOJu0YxIjUjo5//fy9+05z0NkzFZIKNmsH3F023wi5IMn1rYqo5t6WRF
        BxySFLi+btEWW/5F6t6UY0tTkk+0Dy0=
X-Google-Smtp-Source: AGHT+IGjEtftlqB0LLmXFgjmJ3akbl0aPACEmLvM5aMb3hhiy69dDS5Db9HczLRrW8o3/3S2Y48SjQ==
X-Received: by 2002:a05:6a20:1386:b0:157:b7d3:2bcb with SMTP id hn6-20020a056a20138600b00157b7d32bcbmr2265909pzc.27.1695220693045;
        Wed, 20 Sep 2023 07:38:13 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b0c6:e5b6:49ef:e0bd? ([2620:15c:211:201:b0c6:e5b6:49ef:e0bd])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b001bf044dc1a6sm11587565plb.39.2023.09.20.07.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 07:38:12 -0700 (PDT)
Message-ID: <a9b436bb-ccc2-4089-aaea-0e3f3f61fcc2@acm.org>
Date:   Wed, 20 Sep 2023 07:38:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Do not access null point in
 ufshpb_remove
Content-Language: en-US
To:     Zhang Hui <masonzhang.xiaomi@gmail.com>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanley.chu@mediatek.com, peng.zhou@mediatek.com,
        yujiaochen@xiaomi.com, yudongbin@xiaomi.com, zhanghui31@xiaomi.com
References: <20230920091226.55663-1-zhanghui31@xiaomi.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230920091226.55663-1-zhanghui31@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 02:12, Zhang Hui wrote:
> If hpb is not enabled or not allowed, some points will not be
> allocated in init flow, so access them will trigger KE in ufshpb
> remove flow.

Since the HPB code has been removed from the kernel, I don't think that
this patch applies. Please always start from the latest kernel version
when preparing patches.

Thanks,

Bart.

