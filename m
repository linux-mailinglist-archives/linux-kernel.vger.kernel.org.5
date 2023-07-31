Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981567689CC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjGaCFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGaCFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:05:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDF8103;
        Sun, 30 Jul 2023 19:05:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B53BB60E17;
        Mon, 31 Jul 2023 02:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D04C433C8;
        Mon, 31 Jul 2023 02:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690769110;
        bh=J3Qdb98+GWavvdZk662DYh/gIkDmR4IkuHIiYvb53BA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SKz23Bah7boRJh+ZYY9MdmjKET6dvDmnpKTR60SPu3DiqY3Wz37dmauYPoj5r2H4F
         FcoE1JyVbKFlMT7zdqqeUHN2l+QWN7h4NBWvexiNUS9tiOkKwCVM4+Rig2KOsJSuSs
         5Lc2tiLlrhh5Ezn3m/aBFSicoZ8kemf3sW217Py6aHe6jReYSJaAGk9th52InUAP8O
         0qBq07pjokaX1qFxssHB5wvAXqgKYgoYcJY1raCcbaR5qVeOieh5IITcaHs+OCN1J0
         D67/qunnioc0e3WRVhv1d+GT302KNuzGYy3xPwC59khzyzw+YdbYfEUKdYEopyehPw
         H72PwVCA13Vtw==
Message-ID: <7fe583de-966e-1e86-3233-556886c943d1@kernel.org>
Date:   Mon, 31 Jul 2023 11:05:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] scsi:libsas: Simplify sas_queue_reset and remove unused
 code
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>,
        John Garry <john.g.garry@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     louhongxiang@huawei.com
References: <20230729102451.2452826-1-haowenchao2@huawei.com>
 <27bb586c-af75-c2da-1b07-02bfb08e5891@huawei.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <27bb586c-af75-c2da-1b07-02bfb08e5891@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 10:44, Jason Yan wrote:
> Hi Wenchao,
> 
> On 2023/7/29 18:24, Wenchao Hao wrote:
>> sas_queue_reset is always called with param "wait" set to 0, so
>> remove it from this function's param list. And remove unused
>> function sas_wait_eh.
> 
> I did not find any users passing '1' to sas_queue_reset() in the git 
> history. It seems it is never used. So It's ok to remove it, I guess.
> 
> Just one nit, there should be a blank between "scsi:" and "libsas" in 
> the subject:
> 
> scsi: libsas: Simplify sas_queue_reset and remove unused code
> 
> Otherwise looks good to me:
> Reviewed-by: Jason Yan <yanaijie@huawei.com>

Yeah, code wise, it looks good.
However, I am seeing issues with completions for commands that use command
duration limits. There are some unusual completions that needs special handling
with CDL (e.g. some aborted commands can be notified with a success and
sense-data-available-bit set. For these, we kick libata-EH but it seems that
this is not well working with libsas. So I wonder if this code may need to be
used for CDL... So let's please hold on before applying this. Let me check the
CDL issues I am seeing first.

-- 
Damien Le Moal
Western Digital Research

