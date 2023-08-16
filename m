Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B689477DE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243889AbjHPK1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243414AbjHPK1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:27:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDEE719A1;
        Wed, 16 Aug 2023 03:27:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61BAE1063;
        Wed, 16 Aug 2023 03:28:19 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 433D13F762;
        Wed, 16 Aug 2023 03:27:36 -0700 (PDT)
Date:   Wed, 16 Aug 2023 11:27:32 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] firmware: arm_scmi: Add optional flags to
 extended names helper
Message-ID: <ZNyklIL7qGhJnDiJ@pluto>
References: <cover.1691518313.git.oleksii_moisieiev@epam.com>
 <318eb79c7e1ddb1f964a901e778a0475bf18c85b.1691518313.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <318eb79c7e1ddb1f964a901e778a0475bf18c85b.1691518313.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 06:25:35PM +0000, Oleksii Moisieiev wrote:
> From: Cristian Marussi <cristian.marussi@arm.com>
> 
> Some recently added SCMI protocols needs an additional flags parameter to
> be able to properly configure the command used to query the extended name
> of a resource.
> 

Hi Oleksii,

> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---

You need to apply also your Signed-off as last in V5 for this to be
accepted AND beside this I spotted a bug while re-testing this. (my bad)
See down below a possible fix.

>  drivers/firmware/arm_scmi/clock.c     | 2 +-
>  drivers/firmware/arm_scmi/driver.c    | 7 +++++--
>  drivers/firmware/arm_scmi/perf.c      | 3 ++-
>  drivers/firmware/arm_scmi/power.c     | 2 +-
>  drivers/firmware/arm_scmi/powercap.c  | 2 +-
>  drivers/firmware/arm_scmi/protocols.h | 3 ++-
>  drivers/firmware/arm_scmi/reset.c     | 3 ++-
>  drivers/firmware/arm_scmi/sensors.c   | 2 +-
>  drivers/firmware/arm_scmi/voltage.c   | 2 +-
>  9 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index 96060bf90a24..e6e087686e8c 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -169,7 +169,7 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>  	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x2) {
>  		if (SUPPORTS_EXTENDED_NAMES(attributes))
>  			ph->hops->extended_name_get(ph, CLOCK_NAME_GET, clk_id,
> -						    clk->name,
> +						    NULL, clk->name,
>  						    SCMI_MAX_STR_SIZE);
>  
>  		if (SUPPORTS_RATE_CHANGED_NOTIF(attributes))
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index e7d97b59963b..729201d8f935 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -1438,6 +1438,7 @@ struct scmi_msg_resp_domain_name_get {
>   * @ph: A protocol handle reference.
>   * @cmd_id: The specific command ID to use.
>   * @res_id: The specific resource ID to use.
> + * @flags: A pointer to specific flags to use, if any.
>   * @name: A pointer to the preallocated area where the retrieved name will be
>   *	  stored as a NULL terminated string.
>   * @len: The len in bytes of the @name char array.
> @@ -1445,8 +1446,8 @@ struct scmi_msg_resp_domain_name_get {
>   * Return: 0 on Succcess
>   */
>  static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
> -					 u8 cmd_id, u32 res_id, char *name,
> -					 size_t len)
> +					 u8 cmd_id, u32 res_id, u32 *flags,
> +					 char *name, size_t len)
>  {
>  	int ret;
>  	struct scmi_xfer *t;
> @@ -1458,6 +1459,8 @@ static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
>  		goto out;
>  
>  	put_unaligned_le32(res_id, t->tx.buf);
> +	if (flags)
> +		put_unaligned_le32(*flags, t->tx.buf + sizeof(res_id));
>  	resp = t->rx.buf;
>  
>  	ret = ph->xops->do_xfer(ph, t);

Here my patch is buggy since when you provide the optional flags they
are after the res_id parameter BUT the previous xfer_get_init still
requires an xfer with a tx_len size of sizeof(res_id) ONLY, so while the
flags will fit into tx.buf that second optional flags field won't be
sent because the core SCMI stack will see t->tx.len == 4 :<
(so this flags extension wont work when needed in Pinctrl)

A possible fix that I tested consist in changing this snippet with:

-->8---
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b5957cc12fee..06c101edba7f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1438,6 +1438,7 @@ struct scmi_msg_resp_domain_name_get {
  * @ph: A protocol handle reference.
  * @cmd_id: The specific command ID to use.
  * @res_id: The specific resource ID to use.
+ * @flags: A pointer to specific flags to use, if any.
  * @name: A pointer to the preallocated area where the retrieved name will be
  *       stored as a NULL terminated string.
  * @len: The len in bytes of the @name char array.
@@ -1445,19 +1446,22 @@ struct scmi_msg_resp_domain_name_get {
  * Return: 0 on Succcess
  */
 static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
-                                        u8 cmd_id, u32 res_id, char *name,
-                                        size_t len)
+                                        u8 cmd_id, u32 res_id, u32 *flags,
+                                        char *name, size_t len)
 {
        int ret;
+       size_t txlen;
        struct scmi_xfer *t;
        struct scmi_msg_resp_domain_name_get *resp;
 
-       ret = ph->xops->xfer_get_init(ph, cmd_id, sizeof(res_id),
-                                     sizeof(*resp), &t);
+       txlen = !flags ? sizeof(res_id) : sizeof(res_id) + sizeof(*flags);
+       ret = ph->xops->xfer_get_init(ph, cmd_id, txlen, sizeof(*resp), &t);
        if (ret)
                goto out;
 
        put_unaligned_le32(res_id, t->tx.buf);
+       if (flags)
+               put_unaligned_le32(*flags, t->tx.buf + sizeof(res_id));
        resp = t->rx.buf;
 
        ret = ph->xops->do_xfer(ph, t);


---8<---

My bad,

Thanks,
Cristian
