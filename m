Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E227DCC27
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344082AbjJaLwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344044AbjJaLwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:52:49 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019491
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:52:46 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SKT2b5LY5z1P7mV;
        Tue, 31 Oct 2023 19:49:43 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 31 Oct 2023 19:52:43 +0800
Message-ID: <f7821ded-7650-6e41-38b4-0229644d4938@huawei.com>
Date:   Tue, 31 Oct 2023 19:52:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4.19] arm64: fix a concurrency issue in
 emulation_proc_handler()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231030063709.2443546-1-ruanjinjie@huawei.com>
 <2023103103-revision-gigantic-cc05@gregkh>
From:   Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <2023103103-revision-gigantic-cc05@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/31 19:18, Greg KH wrote:
> On Mon, Oct 30, 2023 at 06:37:09AM +0000, Jinjie Ruan wrote:
>> In linux-6.1, the related code is refactored in commit 124c49b1b5d9
>> ("arm64: armv8_deprecated: rework deprected instruction handling") and this
>> issue was incidentally fixed. I have adapted the patch set to linux stable
>> 5.10. However, 4.19 and 5.10 are too different and the patch set is
>> hard to adapt to 4.19.
> 
> This is also needed for 5.4.y, right?  Now queued up for both.

Right! 5.4.y also need it. Thank you very much.

> 
> thanks,
> 
> greg k-h
> 
> From mboxrd@z Thu Jan  1 00:00:00 1970
> Return-Path: <linux-arm-kernel-bounces+linux-arm-kernel=archiver.kernel.org@lists.infradead.org>
> X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
> 	aws-us-west-2-korg-lkml-1.web.codeaurora.org
> Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
> 	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
> 	(No client certificate requested)
> 	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AC2C4332F
> 	for <linux-arm-kernel@archiver.kernel.org>; Tue, 31 Oct 2023 11:19:01 +0000 (UTC)
> DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
> 	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
> 	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
> 	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
> 	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
> 	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
> 	List-Owner; bh=sHNb70g1HDu0TF54RigSJfYMEz5vBtgGnOr5JOh2HyQ=; b=iFgVKiA+IkzhII
> 	m4gw5nvcyNNhqjko8wsNMeG+gPyXUAkeZPfjW2w2erf+P6b4YZFQ0iuIwjDLzv/SBKpYa+vWmbv5E
> 	/TisXFYw7ISsR7nmNdQMmZWs5VVeGYO7MlP1u1/2Cw7EfSZ28ynjndjexd7fVHeKdB5R2ciVsWPVk
> 	n2v29BlvlRs7MfzHJ2JKYyd0JqFoGKTDPxQA5G2l3+aKt1p+5Ujqvv+adKlaU9ZO+qd/DErfcwATR
> 	BGvjbVo1uYIXyMXqoODe/dZW7BTcnC9WQb5cxnq3GUP2AzfEaStJEYNvX9e6DQKM89EfhU1EBLZMt
> 	e7MdaC4WSAweX4R63wQA==;
> Received: from localhost ([::1] helo=bombadil.infradead.org)
> 	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
> 	id 1qxmlU-0059OC-1J;
> 	Tue, 31 Oct 2023 11:18:32 +0000
> Received: from ams.source.kernel.org ([145.40.68.75])
> 	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
> 	id 1qxmlR-0059Ma-34
> 	for linux-arm-kernel@lists.infradead.org;
> 	Tue, 31 Oct 2023 11:18:31 +0000
> Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
> 	by ams.source.kernel.org (Postfix) with ESMTP id 8E876B810AC;
> 	Tue, 31 Oct 2023 11:18:21 +0000 (UTC)
> Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E680C433C8;
> 	Tue, 31 Oct 2023 11:18:20 +0000 (UTC)
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
> 	s=korg; t=1698751100;
> 	bh=FrkgzgA5lVgOv9L7nzUu3Pnkn7b1h5ivphcK2rmy0/k=;
> 	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
> 	b=0SnFDTNYaKYCbdOzEos6VTDFSfwrsP68TOPQnm1RW6NlEHxCMLjW5JSmUoK5ya9Yn
> 	 wvsTROrz11Ki59JxvLNnYJdmRMpdVzi6WC2gjr3O2xq6Rd0NE5r/0OMIHmdM+ucQvJ
> 	 c0k+YQyEE43MNueByonhQ6Zw4tfdwPoxruNsrMr4=
> Date: Tue, 31 Oct 2023 12:18:17 +0100
> From: Greg KH <gregkh@linuxfoundation.org>
> To: Jinjie Ruan <ruanjinjie@huawei.com>
> Cc: catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
> 	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v4.19] arm64: fix a concurrency issue in
>  emulation_proc_handler()
> Message-ID: <2023103103-revision-gigantic-cc05@gregkh>
> References: <20231030063709.2443546-1-ruanjinjie@huawei.com>
> MIME-Version: 1.0
> Content-Disposition: inline
> In-Reply-To: <20231030063709.2443546-1-ruanjinjie@huawei.com>
> X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
> X-CRM114-CacheID: sfid-20231031_041830_159334_D1F4D83C 
> X-CRM114-Status: GOOD (  10.35  )
> X-BeenThere: linux-arm-kernel@lists.infradead.org
> X-Mailman-Version: 2.1.34
> Precedence: list
> List-Id: <linux-arm-kernel.lists.infradead.org>
> List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
>  <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
> List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
> List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
> List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
> List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
>  <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
> Content-Type: text/plain; charset="us-ascii"
> Content-Transfer-Encoding: 7bit
> Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
> Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=archiver.kernel.org@lists.infradead.org
> 
> On Mon, Oct 30, 2023 at 06:37:09AM +0000, Jinjie Ruan wrote:
>> In linux-6.1, the related code is refactored in commit 124c49b1b5d9
>> ("arm64: armv8_deprecated: rework deprected instruction handling") and this
>> issue was incidentally fixed. I have adapted the patch set to linux stable
>> 5.10. However, 4.19 and 5.10 are too different and the patch set is
>> hard to adapt to 4.19.
> 
> This is also needed for 5.4.y, right?  Now queued up for both.
> 
> thanks,
> 
> greg k-h
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
