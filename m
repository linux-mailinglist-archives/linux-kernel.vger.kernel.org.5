Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D93B76416F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 23:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjGZVvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 17:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGZVvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:51:05 -0400
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A836FA;
        Wed, 26 Jul 2023 14:51:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.valinux.co.jp (Postfix) with ESMTP id D5FA6A9284;
        Thu, 27 Jul 2023 06:51:02 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
        by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h08FdhZsu1iL; Thu, 27 Jul 2023 06:51:02 +0900 (JST)
Received: from [172.16.3.34] (vagw.valinux.co.jp [210.128.90.14])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.valinux.co.jp (Postfix) with ESMTPSA id B08C2A8FCF;
        Thu, 27 Jul 2023 06:51:02 +0900 (JST)
Message-ID: <f2db2739-a11f-2b83-6859-584e279a8a52@valinux.co.jp>
Date:   Thu, 27 Jul 2023 06:51:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ACPI: tables: Fix NULL dereference by
 acpi_os_map_memory()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <9445401f-7cfb-bbb5-e25c-28f578efa212@valinux.co.jp>
 <CAJZ5v0jSyE5chyVFFCaqOtE-huf8YH0mD6_udj2w4oA8KoN9qw@mail.gmail.com>
Content-Language: en-US
From:   Kiwamu Okabe <okabe@valinux.co.jp>
In-Reply-To: <CAJZ5v0jSyE5chyVFFCaqOtE-huf8YH0mD6_udj2w4oA8KoN9qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SORBS_DUL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rafael,

On 7/26/23 23:35, Rafael J. Wysocki wrote:
> On Wed, Jul 26, 2023 at 6:53 AM Kiwamu Okabe <okabe@valinux.co.jp> wrote:
>>
>> The Infer static analyzer https://fbinfer.com/ reports following
>> NULL poinster dereference by the acpi_os_map_memory() function.
>> I believe this patch does fix the issue without any panic.
> 
> Please demonstrate to me that the NULL pointer dereference can
> actually happen in this code.

The `acpi_table_initrd_override()` function potentially occurs NULL pointer
dereference on `table->length`,

```
	while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
		table = acpi_os_map_memory(acpi_tables_addr + table_offset,
					   ACPI_HEADER_SIZE);
		if (table_offset + table->length > all_tables_size) {
			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
			WARN_ON(1);
			return AE_OK;
		}
```

because the acpi_os_map_memory() function potentially returns NULL,

```
void __iomem __ref
*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
{
--snip--
	map = kzalloc(sizeof(*map), GFP_KERNEL);
	if (!map) {
		mutex_unlock(&acpi_ioremap_lock);
		return NULL;
	}
--snip--

void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
{
	return (void *)acpi_os_map_iomem(phys, size);
}
```

because the `kzalloc()` potentially returns NULL.

And also, the other code have NULL check to call `acpi_os_map_memory()` as
following.

```
	subtable_header = acpi_os_map_memory(address, sizeof(*subtable_header));
	if (!subtable_header)
		return -ENOMEM;
--snip--
	rsdp = acpi_os_map_memory(rsdp_address, sizeof(struct acpi_table_rsdp));
	if (!rsdp) {
		return_ACPI_STATUS(AE_NO_MEMORY);
	}
```

>> Signed-off-by: Kiwamu Okabe <okabe@valinux.co.jp>
>> ---
>>  drivers/acpi/tables.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 8ab0a82b4da4..ae7b7343bacf 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -717,6 +717,9 @@ acpi_table_initrd_override(struct acpi_table_header *existing_table,
>>         while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
>>                 table = acpi_os_map_memory(acpi_tables_addr + table_offset,
>>                                            ACPI_HEADER_SIZE);
>> +               if (WARN_ON(!table)) {
>> +                       return AE_OK;
>> +               }
>>                 if (table_offset + table->length > all_tables_size) {
>>                         acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
>>                         WARN_ON(1);
>> @@ -772,6 +775,9 @@ static void __init acpi_table_initrd_scan(void)
>>         while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
>>                 table = acpi_os_map_memory(acpi_tables_addr + table_offset,
>>                                            ACPI_HEADER_SIZE);
>> +               if (WARN_ON(!table)) {
>> +                       return;
>> +               }
>>                 if (table_offset + table->length > all_tables_size) {
>>                         acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
>>                         WARN_ON(1);
>> --
>> 2.39.2
>>
> 

Best Regards,
-- 
Kiwamu Okabe at VAJ
