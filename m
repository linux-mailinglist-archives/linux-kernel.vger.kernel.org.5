Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D7F75ECB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjGXHqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjGXHqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:46:32 -0400
Received: from codesynthesis.com (codesynthesis.com [188.40.148.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D283B1A1;
        Mon, 24 Jul 2023 00:46:29 -0700 (PDT)
Received: from brak.codesynthesis.com (unknown [105.186.254.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id 53D2F60C42;
        Mon, 24 Jul 2023 07:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
        s=mail1; t=1690184788;
        bh=7CFLrGViKFLB/jakDjumlAZwdK59THEMB4BbQvsu0TU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From;
        b=GMCA4tJ5+604QBJzpk4MgmSeMI4Zb/pgMSZSAu9JEjUArXkHPDU4o/uSdF3NBtZGq
         O1v4uoyJoZMAXgHmOTdkQdqgB6pHwTLBqZe8mMNv1/yghnXAyfXxX54b6PsvMF4aoV
         Cq+HAM/eJ+e1nMPwUcNT/HiGkxlKeDF7xPN8LGMfxn/wbZ6lJPWWJd9cNBakT1BdBs
         HyZqh+zyGyCpb/MuUwnW1A22qgHB/YrOTk3NpjpRkQ+F8uttdZ7RjojHh4aIMg0csT
         /GZUoePM5in/o1EOyJCGVGq2JGjxsP7NHaQdDxr6BQbnKtgMOZ3Py4bGyxA9li97J4
         i8pWnykvopoFA==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
        id 575B4142D4E; Mon, 24 Jul 2023 09:46:54 +0200 (SAST)
From:   Boris Kolpackov <boris@codesynthesis.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Kolpackov <boris@codesynthesis.com>
Subject: [PATCH 1/1] kconfig: port qconf to work with Qt6 in addition to Qt5
Date:   Mon, 24 Jul 2023 09:46:25 +0200
Message-Id: <20230724074625.458456-2-boris@codesynthesis.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230724074625.458456-1-boris@codesynthesis.com>
References: <20230724074625.458456-1-boris@codesynthesis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with Qt5 5.15 and Qt6 6.4. Note that earlier versions of Qt5
are no longer guaranteed to work.

Signed-off-by: Boris Kolpackov <boris@codesynthesis.com>
---
 scripts/kconfig/qconf.cc | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 78087b2..3a4d7a1 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -5,10 +5,11 @@
  */
 
 #include <QAction>
+#include <QActionGroup>
 #include <QApplication>
 #include <QCloseEvent>
 #include <QDebug>
-#include <QDesktopWidget>
+#include <QScreen>
 #include <QFileDialog>
 #include <QLabel>
 #include <QLayout>
@@ -17,6 +18,7 @@
 #include <QMenuBar>
 #include <QMessageBox>
 #include <QToolBar>
+#include <QRegularExpression>
 
 #include <stdlib.h>
 
@@ -1126,7 +1128,7 @@ QString ConfigInfoView::debug_info(struct symbol *sym)
 
 QString ConfigInfoView::print_filter(const QString &str)
 {
-	QRegExp re("[<>&\"\\n]");
+	QRegularExpression re("[<>&\"\\n]");
 	QString res = str;
 	for (int i = 0; (i = res.indexOf(re, i)) >= 0;) {
 		switch (res[i].toLatin1()) {
@@ -1322,15 +1324,15 @@ ConfigMainWindow::ConfigMainWindow(void)
 	int width, height;
 	char title[256];
 
-	QDesktopWidget *d = configApp->desktop();
 	snprintf(title, sizeof(title), "%s%s",
 		rootmenu.prompt->text,
 		""
 		);
 	setWindowTitle(title);
 
-	width = configSettings->value("/window width", d->width() - 64).toInt();
-	height = configSettings->value("/window height", d->height() - 64).toInt();
+	QRect g = configApp->primaryScreen()->geometry();
+	width = configSettings->value("/window width", g.width() - 64).toInt();
+	height = configSettings->value("/window height", g.height() - 64).toInt();
 	resize(width, height);
 	x = configSettings->value("/window x");
 	y = configSettings->value("/window y");
@@ -1379,17 +1381,17 @@ ConfigMainWindow::ConfigMainWindow(void)
 		this, &ConfigMainWindow::goBack);
 
 	QAction *quitAction = new QAction("&Quit", this);
-	quitAction->setShortcut(Qt::CTRL + Qt::Key_Q);
+	quitAction->setShortcut(Qt::CTRL | Qt::Key_Q);
 	connect(quitAction, &QAction::triggered,
 		this, &ConfigMainWindow::close);
 
 	QAction *loadAction = new QAction(QPixmap(xpm_load), "&Load", this);
-	loadAction->setShortcut(Qt::CTRL + Qt::Key_L);
+	loadAction->setShortcut(Qt::CTRL | Qt::Key_L);
 	connect(loadAction, &QAction::triggered,
 		this, &ConfigMainWindow::loadConfig);
 
 	saveAction = new QAction(QPixmap(xpm_save), "&Save", this);
-	saveAction->setShortcut(Qt::CTRL + Qt::Key_S);
+	saveAction->setShortcut(Qt::CTRL | Qt::Key_S);
 	connect(saveAction, &QAction::triggered,
 		this, &ConfigMainWindow::saveConfig);
 
@@ -1403,7 +1405,7 @@ ConfigMainWindow::ConfigMainWindow(void)
 	connect(saveAsAction, &QAction::triggered,
 		this, &ConfigMainWindow::saveConfigAs);
 	QAction *searchAction = new QAction("&Find", this);
-	searchAction->setShortcut(Qt::CTRL + Qt::Key_F);
+	searchAction->setShortcut(Qt::CTRL | Qt::Key_F);
 	connect(searchAction, &QAction::triggered,
 		this, &ConfigMainWindow::searchConfig);
 	singleViewAction = new QAction(QPixmap(xpm_single_view), "Single View", this);
@@ -1750,11 +1752,21 @@ void ConfigMainWindow::closeEvent(QCloseEvent* e)
 		e->accept();
 		return;
 	}
-	QMessageBox mb("qconf", "Save configuration?", QMessageBox::Warning,
-			QMessageBox::Yes | QMessageBox::Default, QMessageBox::No, QMessageBox::Cancel | QMessageBox::Escape);
-	mb.setButtonText(QMessageBox::Yes, "&Save Changes");
-	mb.setButtonText(QMessageBox::No, "&Discard Changes");
-	mb.setButtonText(QMessageBox::Cancel, "Cancel Exit");
+
+	QMessageBox mb(QMessageBox::Icon::Warning, "qconf",
+		       "Save configuration?");
+
+	QPushButton *yb = mb.addButton(QMessageBox::Yes);
+	QPushButton *db = mb.addButton(QMessageBox::No);
+	QPushButton *cb = mb.addButton(QMessageBox::Cancel);
+
+	yb->setText("&Save Changes");
+	db->setText("&Discard Changes");
+	cb->setText("Cancel Exit");
+
+	mb.setDefaultButton(yb);
+	mb.setEscapeButton(cb);
+
 	switch (mb.exec()) {
 	case QMessageBox::Yes:
 		if (saveConfig())
-- 
2.40.1

