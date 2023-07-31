Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F6D76A18B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjGaTyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGaTyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:54:45 -0400
Received: from abi149hd127.arn1.oracleemaildelivery.com (abi149hd127.arn1.oracleemaildelivery.com [129.149.84.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8545C19A2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=ApYvMZAdcht4TuxINHU06qR0evDmcGeYdQJ2jN5Iu0M=;
 b=uPbrlxINyTbk0xDEKLNPuEnPz00ELPAqDUwA60Mnc5KrPVOefmisSQxRSdnP/8++FfunUihhi3jp
   E6jmO95xJvBfzMzYerhgygg/2hGP5Fb9/byedmopUEhI38ts+ETtPMye2YnqO49UTNJknvR2HIae
   YBwyRZNBxP3BhlVhmJsoZZiGMbH5rEaB4a3yaN75L35mPoG46919Y22GZp4E4i+vV2jgslUN6mT+
   PuQ0+jYT4m8LdsLWXiHRuAqaAEmTJP7sK+WOpNceGIjbweHnNV0ELWssPZ51CWmdczk4BXYQ/Y9V
   +nJLO1wmg+h2hYu94nMt7x50D+kgbFBWv0TLYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=ApYvMZAdcht4TuxINHU06qR0evDmcGeYdQJ2jN5Iu0M=;
 b=ZE9p12PndKQU3/xYesCzM4nZrIddzZyNh5tJgaBGsp8/qf7nyc0GwMi6BfmN55K5DqBT4NV5czKx
   6bokZCKWigwbp33rGHN1U4uS9erP6dVZh4SOjkAIwVKIBz9kuTEiH5MEw0PvVwFufk8Ow0CeRAKM
   WN9NST+ScUgY9gRT1GNYm6sY7SMzndeqslqBxGk0ATsYuuz686yui9orUeHd5IXfX9u6G+eKNWS7
   Z+evzo/3jC+oyiKD3PAhBCazsIsKPvMpqU2kGeZv7LVcttiw683uAv1ut7yo07wixSQCc1JHZFgC
   J3G/y8n9uFWIr0qiJaTXw9Zi5i6b0e2FfqSqfQ==
Received: by omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230629 64bit (built Jun 29
 2023))
 with ESMTPS id <0RYO009JYFB7CG00@omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Mon, 31 Jul 2023 19:54:43 +0000 (GMT)
Message-id: <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
Date:   Mon, 31 Jul 2023 21:54:39 +0200
MIME-version: 1.0
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Content-language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, nilskruse97@gmail.com,
        David.Chang@amd.com
References: <20230731185103.18436-1-mario.limonciello@amd.com>
 <ZMgHE2wu4T4OfrTR@kbusch-mbp>
From:   August Wikerfors <git@augustwikerfors.se>
In-reply-to: <ZMgHE2wu4T4OfrTR@kbusch-mbp>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAGxKd0J+EDPNkJxyVSwXV8t9u0oYmwvO47EmDb/N7KkuuHQNewGDNL7XqL4XvXk
 NwsfeuoNmYe+xIBGUiBBiGydppa6afCXI4mXSqMYQSzh0LCpRHGRYZp0Z5pPSV6m
 2vaC2y+J9jEyN6SPceOCs3Vg1rRCQvcDm1dEl3ZkN/xO2Faw6zrFobjfsuLvsln3
 KKs9Mo5OffjrhiWe5ePAH9jDWhU2nqSH1/sJVsLJFq0+nD+CT0cDtLxv9XKtizQ4
 hcaCnH0vbhSesqKz9/2AqSCDNdEw3tPMSxItvf17VWrIlWfODo9+F+9rhkkjlQQY
 kWzIWjuG6T6xoIEKYCPKnt58pZX071TeN3MsCSlgwNgIHqrHf9bFe2beuK5JDDq6
 PJWbWqoi7OI/KMhB1MhQq5QKcXkLcbBBKsYTrrrQWVqW8F68E1xYqk15kvWxcHFj OSBNOg==
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-31 21:10, Keith Busch wrote:
> On Mon, Jul 31, 2023 at 01:51:03PM -0500, Mario Limonciello wrote:
>> Samsung PM9B1 has problems after resume because NSID has changed.
>> This has been reported in the past on OEM varities of PM9B1 parts
>> and fixed by firmware updates on 'some' of those parts.
>>
>> However this same issue also happens on 'retail' PM9B1 parts which
>> Samsung has not released firmware updates for.
>>
>> As the check has been relaxed at startup for multiple disks with
>> duplicate NSIDs with commit ac522fc6c3165 ("nvme: don't reject
>> probe due to duplicate IDs for single-ported PCIe devices") also
>> relax the check that runs on resume for NSIDs and mark them bogus
>> if this occurs on resume.
> 
> How could the driver tell the difference between the device needing a
> quirk compared to a rapid delete-create-attach namespace sequence?
> Proceeding with the namespace now may get dirty writes intended for the
> previous namespace, corrupting the new one.
> 
> The commit you mentioned tries to constrain allowing duplication where
> we can reasonably assume the quirk is needed. If we need to do similiar
> for this condition, one possible constraint might be that the device
> doesn't report OACS bit 3 (Namespace Management).

It looks like that would work for the PM9B1:
> $ sudo nvme id-ctrl -H /dev/nvme0
> [...] > oacs      : 0x17
>   [10:10] : 0   Lockdown Command and Feature Not Supported
>   [9:9] : 0     Get LBA Status Capability Not Supported
>   [8:8] : 0     Doorbell Buffer Config Not Supported
>   [7:7] : 0     Virtualization Management Not Supported
>   [6:6] : 0     NVMe-MI Send and Receive Not Supported
>   [5:5] : 0     Directives Not Supported
>   [4:4] : 0x1   Device Self-test Supported
>   [3:3] : 0     NS Management and Attachment Not Supported
>   [2:2] : 0x1   FW Commit and Download Supported
>   [1:1] : 0x1   Format NVM Supported
>   [0:0] : 0x1   Security Send and Receive Supported

Regards,
August Wikerfors
